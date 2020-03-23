import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter/widgets.dart' hide Image;

class PaintSurface extends StatefulWidget {
  final PainterController painterController;

  PaintSurface(PainterController painterController)
      : this.painterController = painterController,
        super(key: new ValueKey<PainterController>(painterController));

  @override
  _PaintSurfaceState createState() => new _PaintSurfaceState();
}

class _PaintSurfaceState extends State<PaintSurface> {
  bool _finished;

  @override
  void initState() {
    super.initState();
    _finished = false;
    widget.painterController._widgetFinish = _finish;
  }

  Size _finish() {
    setState(() {
      _finished = true;
    });
    return context.size;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = new CustomPaint(
      willChange: true,
      painter: new _PaintSurfacePainter(widget.painterController._pathHistory,
          repaint: widget.painterController),
    );
    child = new ClipRect(child: child);
    if (!_finished) {
      child = new GestureDetector(
        child: child,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      );
    }
    return new Container(
      child: child,
      width: double.infinity,
      height: double.infinity,
    );
  }

  void _onPanStart(DragStartDetails start) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController._pathHistory.add(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController._pathHistory.updateCurrent(pos);
    widget.painterController._notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController._pathHistory.endCurrent();
    widget.painterController._notifyListeners();
  }
}

class _PaintSurfacePainter extends CustomPainter {
  final _PathHistory _path;

  _PaintSurfacePainter(this._path, {Listenable repaint})
      : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(_PaintSurfacePainter oldDelegate) {
    return true;
  }
}

class _PathHistory {
  List<MapEntry<Path, Paint>> _paths;
  List<MapEntry<Path, Paint>> _redoPaths;
  Paint currentPaint;
  Paint _backgroundPaint;
  GridType _gridType = GridType.NONE;
  bool _inDrag;
  GridDrawer canvasDrawer;

  GridType get gridType => _gridType;

  set gridType(GridType gridType) {
    _gridType = gridType;
  }

  _PathHistory() {
    _paths = new List<MapEntry<Path, Paint>>();
    _redoPaths = new List<MapEntry<Path, Paint>>();
    _inDrag = false;
    _backgroundPaint = new Paint()..color = Colors.grey.shade200;
    canvasDrawer = GridDrawer();
  }

  void undo() {
    if (!_inDrag) {
      _redoPaths.add(_paths.removeLast());
    }
  }

  void redo() {
    if (!_inDrag) {
      _paths.add(_redoPaths.removeLast());
    }
  }

  void clear() {
    if (!_inDrag) {
      _paths.clear();
      _redoPaths.clear();
    }
  }

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = new Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _paths.add(new MapEntry<Path, Paint>(path, currentPaint));
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      Path path = _paths.last.key;
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void endCurrent() {
    _inDrag = false;
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
        new Rect.fromLTWH(0.0, 0.0, size.width, size.height), _backgroundPaint);
    canvasDrawer.drawGrids(canvas, size, _gridType);
    for (MapEntry<Path, Paint> path in _paths) {
      canvas.drawPath(path.key, path.value);
    }
  }
}

typedef PictureDetails PictureCallback();

class PictureDetails {
  final Picture picture;
  final int width;
  final int height;

  const PictureDetails(this.picture, this.width, this.height);

  Future<Image> toImage() {
    return picture.toImage(width, height);
  }

  Future<Uint8List> toPNG() async {
    final image = await toImage();
    return (await image.toByteData(format: ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}

class PainterController extends ChangeNotifier {
  Color _drawColor = new Color.fromARGB(255, 0, 0, 0);
  GridType _gridType;

  double _thickness = 1.0;
  PictureDetails _cached;
  _PathHistory _pathHistory;
  ValueGetter<Size> _widgetFinish;

  PainterController() {
    _pathHistory = new _PathHistory();
  }

  Color get drawColor => _drawColor;

  set drawColor(Color color) {
    _drawColor = color;
    _updatePaint();
  }

  double get thickness => _thickness;

  set thickness(double t) {
    _thickness = t;
    _updatePaint();
  }

  GridType get gridType => _gridType;

  set gridType(GridType gridType) {
    _gridType = gridType;
    _pathHistory.gridType = gridType;
    notifyListeners();
  }

  void _updatePaint() {
    Paint paint = new Paint();
    paint.color = drawColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;
    _pathHistory.currentPaint = paint;
    notifyListeners();
  }

  void undo() {
    if (!isFinished()) {
      _pathHistory.undo();
      notifyListeners();
    }
  }

  void redo() {
    if (!isFinished()) {
      _pathHistory.redo();
      notifyListeners();
    }
  }

  void _notifyListeners() {
    notifyListeners();
  }

  void clear() {
    if (!isFinished()) {
      _pathHistory.clear();
      notifyListeners();
    }
  }

  PictureDetails finish() {
    if (!isFinished()) {
      _cached = _render(_widgetFinish());
    }
    return _cached;
  }

  PictureDetails _render(Size size) {
    PictureRecorder recorder = new PictureRecorder();
    Canvas canvas = new Canvas(recorder);
    _pathHistory.draw(canvas, size);
    return new PictureDetails(
        recorder.endRecording(), size.width.floor(), size.height.floor());
  }

  bool isFinished() {
    return _cached != null;
  }
}

enum GridType { NONE, RULERS, SQUARE, DOTS }

class GridDrawer {
  final Paint paint = new Paint()..color = Colors.grey.shade700.withAlpha(200);

  void drawGrids(Canvas canvas, Size size, GridType gridType) {
    switch (gridType) {
      case GridType.NONE:
        break;
      case GridType.SQUARE:
        drawSquareGrid(canvas, size, paint);
        break;
      case GridType.DOTS:
        drawDotsGrid(canvas, size, paint);
        break;
      case GridType.RULERS:
        drawRulersGrid(canvas, size, paint);
        break;
    }
  }

  void drawSquareGrid(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < size.width; i += 10) {
      canvas.drawLine(
          Offset(i.toDouble(), 0), Offset(i.toDouble(), size.height), paint);
    }

    drawRulersGrid(canvas, size, paint);
  }

  void drawDotsGrid(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < size.width; i += 10) {
      for (int j = 0; j < size.height; j += 10) {
        canvas.drawCircle(Offset(i.toDouble(), j.toDouble()), 0.75, paint);
      }
    }
  }

  void drawRulersGrid(Canvas canvas, Size size, Paint paint) {
    for (int i = 0; i < size.height; i += 10) {
      canvas.drawLine(
          Offset(0, i.toDouble()), Offset(size.width, i.toDouble()), paint);
    }
  }
}

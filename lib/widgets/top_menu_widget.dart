import 'package:flutter/material.dart';

class TopMenuWidget extends StatelessWidget {
  final bool Function() isNotEmpty;

  const TopMenuWidget({
    Key key,
    @required this.isNotEmpty,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    var _isNotEmpty = isNotEmpty();
                    Navigator.of(context).pop(_isNotEmpty);
                  },
                  icon: Icon(Icons.arrow_back)),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add_alert),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.archive),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}

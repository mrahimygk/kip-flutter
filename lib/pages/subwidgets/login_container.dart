import 'package:flutter/cupertino.dart';

class LoginPageContainer extends StatelessWidget {
  final Widget child;

  const LoginPageContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //TODO: icon here
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0, top: 80.0),
            child: Text("Login to save your note to cloud!"),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: child,
          ),
        ],
      ),
    );
  }
}

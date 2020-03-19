import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kip/models/User.dart';
import 'package:kip/services/db/DatabaseProvider.dart';
import 'package:kip/services/repo/UserRepoImpl.dart';
import 'package:kip/util/StringUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum PageFunctionState { LOGIN, REGISTER }

class _LoginPageState extends State<LoginPage> {
  final userRepo = UserRepoImpl(DatabaseProvider.get);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _passConfirmController = TextEditingController();

  bool _isLoading = false;
  PageFunctionState pageFunctionState = PageFunctionState.LOGIN;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter email', labelText: 'Email Address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email address";
                      } else if (!StringUtils.isValidEmail(value)) {
                        return "Please enter a Valid email address";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'enter password',
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  isLogin()
                      ? Container()
                      : TextFormField(
                          controller: _passConfirmController,
                        ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            isLogin() ? "Login" : "Register",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              if (isLogin()) {
                                userRepo
                                    .login(_emailController.text,
                                        _passController.text)
                                    .then(onSignedIn);
                              } else {
                                userRepo
                                    .signUp(_emailController.text,
                                        _passController.text)
                                    .then(onSignedIn);
                              }
                            }
                          },
                        ),
                  Text("or"),
                  RaisedButton(
                    child: Text(isLogin() ? "Register" : "Login"),
                    onPressed: () {
                      setState(() {
                        if (isLogin())
                          pageFunctionState = PageFunctionState.REGISTER;
                        else
                          pageFunctionState = PageFunctionState.LOGIN;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  isLogin() => pageFunctionState == PageFunctionState.LOGIN;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _passConfirmController.dispose();
    super.dispose();
  }

  FutureOr onSignedIn(User user) {
    userRepo.insert(user);
    setState(() {
      _isLoading = false;
    });
  }
}

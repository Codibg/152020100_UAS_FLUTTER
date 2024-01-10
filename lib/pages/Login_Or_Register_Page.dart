import 'package:flutter/material.dart';
import 'package:algi/pages/Login_Page.dart';

import 'Register_Page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  _LoginOrRegisterPageState createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  //initialy show page
  bool showLoginPage = true;

  //toggle between login and registr
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages,
      );
    }else
    return RegisterPage(
      onTap: togglePages,
    );
  }
}

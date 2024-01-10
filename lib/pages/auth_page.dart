import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:algi/pages/HomePage.dart';
import 'package:algi/pages/Login_Or_Register_Page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User logged in
          if (snapshot.hasData) {
            return HomePage();
          }
          // User not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}

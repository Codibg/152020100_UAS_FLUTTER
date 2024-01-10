import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:algi/components/my_button.dart';
import 'package:algi/components/my_textfield.dart';
import 'package:algi/components/square_tile.dart';

import 'curve_dipper.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  

  // sign user up method
// sign user up method
void signUserUp() async {
  // show loading
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  // try creating the user
  try {
    // Check if the password matches the confirm password
    if (passwordController.text == confirmPasswordController.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop load
      Navigator.pop(context);
    } else {
      // If the passwords don't match, show an error message
      wrongPasswordMessage('Passwords do not match');
    }
  } on FirebaseAuthException catch (e) {
    // pop load
    Navigator.pop(context);
    // handle different exceptions here
    if (e.code == 'weak-password') {
      wrongPasswordMessage('Password is too weak');
    } else if (e.code == 'email-already-in-use') {
      wrongEmailMessage('Email is already in use');
    }
  }
}

  // wrong email message popup
  void wrongEmailMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ClipPath(
                clipper: CurveClipper(),
                child: Image(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  image: const AssetImage('lib/assets/moai.jpg'),
                  fit: BoxFit.cover,
                ),
              ),

              // welcome
              Text(
                'Create an account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 20),

              // email
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // pass
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              // confirm pass
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 20),

              // sign
              MyButton(
                text: 'Sign Up',
                onTap: signUserUp,
              ),

              const SizedBox(height: 30),

              // or
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              // google + apple sign in button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google button
                  SquareTile(imagePath: 'lib/assets/google.png'),

                  SizedBox(width: 25),

                  //apple button
                  SquareTile(imagePath: 'lib/assets/apple.png'),
                ],
              ),

              const SizedBox(height: 20),

              // not
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Login now!',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

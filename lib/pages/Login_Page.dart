import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:algi/components/square_tile.dart';
import 'package:algi/components/my_button.dart';
import 'package:algi/components/my_textfield.dart';
import 'package:algi/pages/curve_dipper.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {
    //show loading
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop load
      if(mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      //pop load
      if(mounted) {
        Navigator.pop(context);
      }
      //wrong email
      if (e.code == 'user-not-found') {
        //show error to user
        if(mounted) {
          wrongEmailMessage();
        }
      }
      //wrong password
      else if (e.code == 'wrong-password') {
        //wrong error to user
        if(mounted) {
          wrongPasswordMessage();
        }
      }
    }
  }

  //wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Incorrect Email'),
        );
      },
    );
  }

  //wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Incorrect Password'),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Image(
                  height: MediaQuery.of(context).size.height / 3.3,
                  width: double.infinity,
                  image: const AssetImage('lib/assets/suit.jpg'),
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'MOAI', // Added a comma here
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 20),

              // email
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 20),

              // pass
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              // forgot
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // sign
              MyButton(
                text: 'Sign In',
                onTap: signUserIn,
              ),

              const SizedBox(height: 35),

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

              const SizedBox(height: 35),
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

              const SizedBox(height: 30),

              // not
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Register now!',
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

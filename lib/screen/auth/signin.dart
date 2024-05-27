// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ficufoide/fetch/fetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../cons/firebase.dart';
import '../../loading/loading.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return isLoading
        ? Loading()
        : Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade400, Colors.green.shade400],
                ),
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Log in",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text("Welcome back to FicuFoide app.",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: brightness == Brightness.light
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 60,
                              child: TextField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !_isPasswordVisible,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: brightness == Brightness.light
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pushNamed(context, '/forgotPass');
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Spacer(),
                                SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await _login(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.blue,
                                      disabledForegroundColor:
                                          Colors.grey.withOpacity(0.38),
                                      disabledBackgroundColor:
                                          Colors.grey.withOpacity(0.12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      "Log in",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "Don't have an Account?",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, '/SignUpPage');
                            },
                            child: Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Future<void> _login(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        currentEmail = FirebaseAuth.instance.currentUser!.email.toString();
      });
      await fetchRole(setState);
      await fetchRole(setState);
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamedAndRemoveUntil(
          context, '/Splashscreen', (route) => false);
      // Navigate to the next screen or do something on successful login
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        setState(() {
          isLoading = false;
        });
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        setState(() {
          isLoading = false;
        });
        message = 'Wrong password provided.';
      } else {
        setState(() {
          isLoading = false;
        });
        message = 'An error occurred. Please try again.';
      }
      setState(() {
        isLoading = false;
      });
      _showErrorDialog(context, message);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog(context, 'An unexpected error occurred.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
//
// Route _toForgotPass() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, anotherAnimation) => ForgotPassPage(),
//     transitionDuration: Duration(milliseconds: 1000),
//     reverseTransitionDuration: Duration(milliseconds: 200),
//     transitionsBuilder: (context, animation, anotherAnimation, child) {
//       animation = CurvedAnimation(
//           parent: animation,
//           reverseCurve: Curves.fastOutSlowIn,
//           curve: Curves.fastLinearToSlowEaseIn);
//
//       return SlideTransition(
//           position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
//               .animate(animation),
//           child: ForgotPassPage());
//     },
//   );
// }
}

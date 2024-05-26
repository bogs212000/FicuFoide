import 'package:ficufoide/fetch/fetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
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
                    SizedBox(width: 15),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 15),
                    Text(
                      "Join FicuFoide app.",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildTextField(_usernameController, "Username",
                          Icons.person, brightness),
                      SizedBox(height: 20),
                      _buildTextField(
                          _emailController,
                          "Email",
                          Icons.email_outlined,
                          brightness,
                          TextInputType.emailAddress),
                      SizedBox(height: 20),
                      _buildPasswordField(
                          _passwordController, "Password", brightness),
                      SizedBox(height: 20),
                      _buildPasswordField(_confirmPasswordController,
                          "Confirm Password", brightness),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 35,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : () => _signUp(context),
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
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "Already have an Account?",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(fontSize: 12, color: Colors.white),
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

  Widget _buildTextField(TextEditingController controller, String hintText,
      IconData icon, Brightness brightness,
      [TextInputType keyboardType = TextInputType.text]) {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hintText,
      Brightness brightness) {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !_isPasswordVisible,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
          hintText: hintText,
          suffixIcon: IconButton(
            icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showErrorDialog(context, 'Passwords do not match.');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_emailController.text.trim())
          .set({
        'username': _usernameController.text,
        'email': _emailController.text.trim(),
        'role': 'user'
      });
      setState(() {
        _isLoading = false;
      });
      fetchRole(setState);
      fetchFoodName(setState);
      Navigator.pushNamedAndRemoveUntil(context, '/AuthWrapper', (route) => false);
      // Navigate to the next screen or display a success message
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      String message;
      if (e.code == 'email-already-in-use') {
        message = 'The email address is already in use by another account.';
      } else if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      _showErrorDialog(context, message);
    } catch (e) {
      setState(() {
        _isLoading = false;
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
}

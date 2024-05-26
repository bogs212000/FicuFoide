// ignore_for_file: prefer_const_constructors

import 'package:ficufoide/screen/auth/wrapper.dart';
import 'package:ficufoide/screen/navbar/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../loading/splashscreen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong."),
            );
          } else if (snapshot.hasData) {
            return Wrapper();
          } else {
            return Splashscreen();
          }
        },
      ),
    );
  }
}
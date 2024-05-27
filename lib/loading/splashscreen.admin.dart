import 'dart:async';

import 'package:ficufoide/screen/navbar/navbar_admin.dart';
import 'package:ficufoide/screen/results/result.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../screen/navbar/navbar.dart';

class SplashscreenAdmin extends StatefulWidget {
  @override
  _SplashscreenAdminState createState() => _SplashscreenAdminState();
}

class _SplashscreenAdminState extends State<SplashscreenAdmin> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NavBarAdmin(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset('assets/lottie/loading.json')
      ),
    );
  }
}
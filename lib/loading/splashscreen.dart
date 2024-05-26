import 'dart:async';

import 'package:ficufoide/screen/results/result.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../screen/navbar/navbar.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NavBar(),
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
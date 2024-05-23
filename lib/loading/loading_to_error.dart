import 'dart:async';

import 'package:ficufoide/screen/results/result.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadError extends StatefulWidget {
  @override
  _LoadErrorState createState() => _LoadErrorState();
}

class _LoadErrorState extends State<LoadError> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultPage(),
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
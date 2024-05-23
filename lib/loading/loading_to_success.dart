import 'dart:async';

import 'package:ficufoide/screen/results/result.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadSuccess extends StatefulWidget {
  @override
  _LoadSuccessState createState() => _LoadSuccessState();
}

class _LoadSuccessState extends State<LoadSuccess> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
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
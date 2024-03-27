// ignore_for_file: prefer_const_constructors

import 'package:ficufoide/screen/home/home.page.dart';
import 'package:ficufoide/screen/navbar/navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: NavBar(),
    );
  }
}

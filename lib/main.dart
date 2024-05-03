// ignore_for_file: prefer_const_constructors

import 'package:ficufoide/screen/auth/signin.dart';
import 'package:ficufoide/screen/food/food.info.dart';
import 'package:ficufoide/screen/home/home.page.dart';
import 'package:ficufoide/screen/navbar/navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key); // Fixed constructor

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FicuFoide',
      debugShowCheckedModeBanner: false,
      home: NavBar(),
      routes: {
        '/showFoodInfoPage': (context) => FoodInfoPage(),
        '/login': (context) => SigninPage(),
      },
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 60),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://scontent.fmnl13-2.fna.fbcdn.net/v/t39.30808-6/399241370_1591190431411220_8935650865096509315_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGuxWmxMpgGsTYYFKmR8slA7JHVzTxU4lnskdXNPFTiWaSctNiuHQyiWD62f190qE_ffxwFAUejfV1JNZ6on3FZ&_nc_ohc=pjqJ6gtMYJAAX_bsJil&_nc_ht=scontent.fmnl13-2.fna&oh=00_AfDXyKbIYZg3tiiWUriU1ngTpmxJaZfdbCEnjHORXSwseQ&oe=66090698'),
                ),
                Spacer(),
                Icon(Icons.menu, size: 40, color: Colors.white,)
              ],
            ),
            Row(
              children: ['Hello! '.text.size(30).color(Colors.white).bold.make(),
                'Ednalyn'.text.size(30).color(Colors.white).bold.make()],
            ),
            Row(
              children: ['Welcome to FicuFoide '.text.size(25).color(Colors.white).make(),],
            ),

            Container()
          ],
        ),
      ),
    );
  }
}

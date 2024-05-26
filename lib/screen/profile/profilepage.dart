import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../cons/const.dart';
import '../../cons/firebase.dart';
import '../../cons/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      setState(() {
        userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int hours = now.hour;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
               Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        role == null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child:
                                    'Sign in'.text.color(Colors.white).make())
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: CachedNetworkImageProvider(
                                'https://t4.ftcdn.net/jpg/04/52/75/21/360_F_452752187_LCS2HVvLfrXDhpVmufmMZ5N6vNee8E0e.jpg'),
                          ),
                        ),
                        Spacer(),
                        hours >= 6 && hours <= 17
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset('assets/sun.png',
                                    height: 70, width: 70),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset('assets/sun.png',
                                    height: 70, width: 70),
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        'Hello '.text.size(30).color(Colors.white).bold.make(),
                        username != null
                            ? '$username'
                                .text
                                .size(30)
                                .color(Colors.white)
                                .bold
                                .make()
                            : 'user'
                                .text
                                .size(30)
                                .color(Colors.white)
                                .bold
                                .make()
                      ],
                    ),
                    Row(
                      children: [
                        'Welcome to FicuFoide '
                            .text
                            .size(25)
                            .color(Colors.white)
                            .make(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 20),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        role != null || username != null ?  Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue, Colors.green],
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 24.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              setState(() {
                                role = '';
                                username = null;
                                currentEmail = null;
                              });
                              Navigator.pushNamedAndRemoveUntil(context, '/Splashscreen', (route) => false);
                            },
                            icon: Icon(
                              Icons.login_outlined,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Sign out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ) : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

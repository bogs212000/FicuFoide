// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:ficufoide/cons/image.dart';
import 'package:ficufoide/fetch/fetch.dart';
import 'package:ficufoide/screen/results/results_widgets/food_images.dart';
import 'package:ficufoide/screen/results/results_widgets/ingredients_list_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/plating_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/res.low.dart';
import 'package:ficufoide/screen/results/results_widgets/steps_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/users_suggest_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    fetchFoodName(setState);
    super.initState();
  }

  @override
  void dispose() {
    ingredientsRes = null;
    instructionsRes = null;
    platingRes = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return resCon == 'low'
        ? ResLow()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: 'Results'.text.bold.make(),
              backgroundColor: Colors.white,
              elevation: 3,
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity, // Adjust width as needed
                          height: 400,
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            // Match the border radius above
                            child: resultImage != null
                                ? Image.file(
                                    resultImage!,
                                    // Your image path
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(),
                          ),
                        ),
                        Positioned(
                          bottom: 0, // Adjust the position as needed
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 20, // Adjust height as needed
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(1), // Shadow color
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Name
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('foods')
                              .doc(resText)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Display loading indicator while fetching data
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return Text(
                                  '...'); // Display message if document doesn't exist
                            }
                            var data = snapshot.data!.data() as Map<String,
                                dynamic>?; // Cast data to Map<String, dynamic> explicitly
                            if (data == null) {
                              return Text('...'); // Handle null case
                            }
                            var foodName = data['foodName']
                                as String?; // Access the 'foodName' field
                            if (foodName == null) {
                              return Text('...'); // Handle null case
                            }
                            return Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    foodName,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                    //Intro
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 5),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('foods')
                              .doc(resText)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Display loading indicator while fetching data
                            }
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return Text(
                                  '...'); // Display message if document doesn't exist
                            }
                            var data = snapshot.data!.data() as Map<String,
                                dynamic>?; // Cast data to Map<String, dynamic> explicitly
                            if (data == null) {
                              return Text('...'); // Handle null case
                            }
                            var foodInfo = data['info'] as String?;
                            ingredientsRes = data['ingredients'];
                            instructionsRes = data['instructions'];
                            platingRes =
                                data['plating']; // Access the 'foodName' field
                            if (foodInfo == null) {
                              return Text('...'); // Handle null case
                            }
                            return Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    foodInfo,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                    FoodImages(),
                    SizedBox(height: 10),
                    //ingredients
                    ingredientsRes == true
                        ? Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                'Ingredients '.text.bold.size(20).make(),
                                Spacer(),
                                'View'
                                    .text
                                    .bold
                                    .size(15)
                                    .color(Colors.grey)
                                    .make(),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 10),
                    ingredientsRes == true
                        ? Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: double.infinity,
                            height: 150,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("foods")
                                  .doc('$resText')
                                  .collection('ingredients')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Something went wrong!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 231, 25, 25),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center();
                                }
                                if (snapshot.data!.size == 0) {
                                  return Center(
                                    child: Text('No Update yet!'),
                                  );
                                }
                                return ListView.builder(
                                  physics: snapshot.data!.size <= 2
                                      ? NeverScrollableScrollPhysics()
                                      : BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(top: 0),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[index];
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    data['ingredient']
                                                        .toString(),
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                    //instruction
                    instructionsRes == true
                        ? Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                'Instructions '.text.bold.size(20).make(),
                                Spacer(),
                                'View'
                                    .text
                                    .bold
                                    .size(15)
                                    .color(Colors.grey)
                                    .make(),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 10),
                    instructionsRes == true
                        ? Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: double.infinity,
                            height: 150,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("foods")
                                  .doc('$resText')
                                  .collection('instructions')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "Something went wrong!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 231, 25, 25),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center();
                                }
                                if (snapshot.data!.size == 0) {
                                  return Center(
                                    child: Text('No Update yet!'),
                                  );
                                }
                                return ListView.builder(
                                  physics: snapshot.data!.size <= 2
                                      ? NeverScrollableScrollPhysics()
                                      : BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(top: 0),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[index];
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    data['step']
                                                        .toString()
                                                        .substring(0, 6),
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    data['step']
                                                        .toString()
                                                        .substring(7),
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                    UsersSuggestWidgets(),
                    SizedBox(height: 10),
                    platingRes == true ? PlatingWidgets() : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: TextField(
                                maxLines: 2,
                                decoration: InputDecoration(
                                  hintText: 'Comment or suggestions',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Thank you!'),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the value to change the border radius
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

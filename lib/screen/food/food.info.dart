// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:ficufoide/screen/food/widgets/add.images.food.dart';
import 'package:uuid/uuid.dart';
import 'package:ficufoide/cons/image.dart';
import 'package:ficufoide/fetch/fetch.dart';
import 'package:ficufoide/screen/results/results_widgets/food_images.dart';
import 'package:ficufoide/screen/results/results_widgets/ingredients_list_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/plating_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/steps_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/users_suggest_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class FoodInfoPage extends StatefulWidget {
  FoodInfoPage({super.key});

  @override
  State<FoodInfoPage> createState() => _FoodInfoPageState();
}

class _FoodInfoPageState extends State<FoodInfoPage> {
  final TextEditingController foodInfoController = TextEditingController();
  final TextEditingController foodIngredientsController =
      TextEditingController();
  final TextEditingController foodInstructionsController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green],
            ),
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        title: 'Edit info'.text.bold.color(Colors.white).make(),
        elevation: 3,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Stack(
              //   children: [
              //     Container(
              //       width: double.infinity, // Adjust width as needed
              //       height: 400,
              //       decoration: BoxDecoration(),
              //       child: ClipRRect(
              //         // Match the border radius above
              //         child: resultImage != null
              //             ? Image.file(
              //           resultImage!,
              //           // Your image path
              //           fit: BoxFit.cover,
              //         )
              //             : SizedBox(),
              //       ),
              //     ),
              //     Positioned(
              //       bottom: 0, // Adjust the position as needed
              //       left: 0,
              //       right: 0,
              //       child: Container(
              //         height: 20, // Adjust height as needed
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               Colors.transparent,
              //               Colors.black.withOpacity(1), // Shadow color
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              //Name
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('foods')
                        .doc('$foodInfoPageDocName')
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                  fontSize: 30, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  )),
              //Intro
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('foods')
                      .doc('$foodInfoPageDocName')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                    if (foodInfo == null) {
                      return TextField(
                        controller: foodInfoController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter text here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ); // Handle null case
                    }
                    // Set the text to the controller
                    foodInfoController.text = foodInfo;

                    return TextField(
                      controller: foodInfoController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter text here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 5),

              //save button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Save the updated text to Firestore
                      FirebaseFirestore.instance
                          .collection('foods')
                          .doc('$foodInfoPageDocName')
                          .update({'info': foodInfoController.text});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Changes saved!'),
                        ),
                      );
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
              AddFoodImages(),
              SizedBox(height: 10),
              //ingredients
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    'Ingredients '.text.bold.size(20).make(),
                    Spacer(),
                    CupertinoSwitch(
                      activeColor: Colors.green.shade900,
                      thumbColor: Colors.white,
                      trackColor: Colors.grey,
                      value: ingredients!,
                      onChanged: (value) async {
                        await FirebaseFirestore.instance
                            .collection('foods')
                            .doc('$foodInfoPageDocName')
                            .update({'ingredients': value});

                        setState(() {
                          ingredients = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                height: 150,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("foods")
                      .doc('$foodInfoPageDocName')
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
                              color: Color.fromARGB(255, 231, 25, 25),
                            ),
                          )
                        ],
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center();
                    }
                    if (snapshot.data!.size == 0) {
                      return Center(
                        child: Text('No uploaded ingredients yet!'),
                      );
                    }
                    return ListView.builder(
                      physics: snapshot.data!.size <= 2
                          ? NeverScrollableScrollPhysics()
                          : BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data['ingredient'].toString(),
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
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
              ),

              //upload ingredients
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: foodIngredientsController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Enter ingredients here. input format: (#. Text)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String docId = Uuid().v4();
                      // Save the updated text to Firestore
                      await FirebaseFirestore.instance
                          .collection('foods')
                          .doc('$foodInfoPageDocName')
                          .collection('ingredients')
                          .doc(docId)
                          .set({
                        'ingredient': foodIngredientsController.text,
                        'createdAt': DateTime.now()
                      });
                      foodIngredientsController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Changes saved!'),
                        ),
                      );
                    },
                    child: Text('Add'),
                  ),
                ],
              ),

              //instruction
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    'Instructions '.text.bold.size(20).make(),
                    Spacer(),
                    CupertinoSwitch(
                      activeColor: Colors.green.shade900,
                      thumbColor: Colors.white,
                      trackColor: Colors.grey,
                      value: instructions!,
                      onChanged: (value) async {
                        await FirebaseFirestore.instance
                            .collection('foods')
                            .doc('$foodInfoPageDocName')
                            .update({'instructions': value});

                        setState(() {
                          instructions = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                height: 150,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("foods")
                      .doc('$foodInfoPageDocName')
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
                              color: Color.fromARGB(255, 231, 25, 25),
                            ),
                          )
                        ],
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center();
                    }
                    if (snapshot.data!.size == 0) {
                      return Center(
                        child: Text('No Uploaded Instructions yet!'),
                      );
                    }
                    return ListView.builder(
                      physics: snapshot.data!.size <= 2
                          ? NeverScrollableScrollPhysics()
                          : BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        int itemNumber = index + 1;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data['step'].toString().substring(0, 6),
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data['step'].toString().substring(7),
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
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
              ),
              //upload instructions
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: foodInstructionsController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText:
                        'Enter instructions here. input format : (Step # Text)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String docId = Uuid().v4();
                      // Save the updated text to Firestore
                      await FirebaseFirestore.instance
                          .collection('foods')
                          .doc('$foodInfoPageDocName')
                          .collection('instructions')
                          .doc(docId)
                          .set(
                        {
                          'step': foodInstructionsController.text,
                          'createdAt': DateTime.now()
                        },
                      );
                      foodInstructionsController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Changes saved!'),
                        ),
                      );
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              PlatingWidgets(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

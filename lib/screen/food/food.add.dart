// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../cons/image.dart';

class FoodAddPage extends StatefulWidget {
  const FoodAddPage({super.key});

  @override
  State<FoodAddPage> createState() => _FoodAddPageState();
}

class _FoodAddPageState extends State<FoodAddPage> {
  TextEditingController collectionName = TextEditingController();

  bool add = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.only(left: 15, bottom: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade700,
                    Colors.green.shade500,
                  ], // Define your gradient colors here
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      'Add Food'.text.color(Colors.white).bold.size(20).make(),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            add = !add;
                          });
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                  add == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextField(
                                controller: collectionName,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: 'Food Name',
                                  prefixIcon:
                                      Icon(Icons.fastfood, color: Colors.green),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection(
                                            'foods')
                                        .doc(collectionName.text.toString())
                                        .set({
                                      'docName': collectionName.text.toString(),
                                      'foodName': collectionName.text
                                          .toString()
                                          .substring(2),
                                      'ingredients': true,
                                      'instructions': true,
                                      'plating': true,
                                    });
                                    collectionName.clear();
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  disabledForegroundColor:
                                      Colors.grey.withOpacity(0.38),
                                  disabledBackgroundColor:
                                      Colors.grey.withOpacity(0.12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            )
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("foods").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Somthing went wrong!",
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
                  if (snapshot.data?.size == 0) {
                    return Center(
                      child: Text('No Update yet!'),
                    );
                  }
                  Row(children: const [
                    TextField(
                      decoration: InputDecoration(),
                    )
                  ]);
                  return ListView(
                    physics: snapshot.data!.size <= 4
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 0),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 10),
                        child: Card(
                          shadowColor: Color.fromARGB(255, 34, 34, 34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                ingredients = data['ingredients'];
                                instructions = data['instructions'];
                                plating = data['plating'];
                                foodInfoPageDocName = data['docName'];
                              });
                              Navigator.pushNamed(context, '/showFoodInfoPage');
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      '${data['foodName']}'
                                          .text
                                          .bold
                                          .size(20)
                                          .make(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

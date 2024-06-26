// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficufoide/cons/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class IngredientsWidgets extends StatefulWidget {
  const IngredientsWidgets({super.key});

  @override
  State<IngredientsWidgets> createState() => _IngredientsWidgetsState();
}

class _IngredientsWidgetsState extends State<IngredientsWidgets> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              'Ingredients '.text.bold.size(20).make(),
              Spacer(),
              'View'.text.bold.size(15).color(Colors.grey).make(),
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
                .doc('$resText')
                .collection('ingredients').orderBy('createdAt')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return Center(
                );
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
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
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
                                  softWrap: false,
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
      ],
    );
  }
}

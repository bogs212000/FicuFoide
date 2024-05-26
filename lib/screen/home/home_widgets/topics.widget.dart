// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopicsWidget extends StatefulWidget {
  const TopicsWidget({super.key});

  @override
  State<TopicsWidget> createState() => _TopicsWidgetState();
}

class _TopicsWidgetState extends State<TopicsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  'Topics'.text.bold.size(20).make(),
                ],
              ),
              Row(
                children: [
                  'More suggestions provided by users!'.text.size(15).make(),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          height: 150,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('foods').where('ingredients', isEqualTo: true ).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No topics available.'));
              }

              final topics = snapshot.data!.docs;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          'https://t4.ftcdn.net/jpg/04/52/75/21/360_F_452752187_LCS2HVvLfrXDhpVmufmMZ5N6vNee8E0e.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.9),
                          ),
                          height: 150,
                          width: 120,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        topic['foodName'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          'https://t4.ftcdn.net/jpg/04/52/75/21/360_F_452752187_LCS2HVvLfrXDhpVmufmMZ5N6vNee8E0e.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(60),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

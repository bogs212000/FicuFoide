import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ficufoide/cons/image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersSuggestWidgets extends StatefulWidget {
  const UsersSuggestWidgets({super.key});

  @override
  State<UsersSuggestWidgets> createState() => _UsersSuggestWidgetsState();
}

class _UsersSuggestWidgetsState extends State<UsersSuggestWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              'Suggestions'.text.bold.size(20).make(),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 100,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('foods')
                .doc(resText)
                .collection(resText!).orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No data found.'));
              }

              final users = snapshot.data!.docs;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue[50],
                      ),
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: CachedNetworkImageProvider(
                                  'https://t4.ftcdn.net/jpg/04/52/75/21/360_F_452752187_LCS2HVvLfrXDhpVmufmMZ5N6vNee8E0e.jpg',
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  user
                                  ['username'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            user['comment'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
          padding: EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue[50]),
                    width: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                  'https://scontent.fmnl4-5.fna.fbcdn.net/v/t39.30808-1/433276214_1581602276011956_5532162512647413841_n.jpg?stp=c0.0.160.160a_dst-jpg_p160x160&_nc_cat=106&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeEU9qRb-6Fg_wzQnZz0yOn-WW1yWUilejJZbXJZSKV6MlDCATCbqoA8AFpXU8OqDm83727NwLOjmb2INgpNh6QU&_nc_ohc=UzGK0wfBkAIAb5y7aI3&_nc_ht=scontent.fmnl4-5.fna&oh=00_AfBsdlIttLDjQUq2UheMqpa1ixcNP_VUiinYvjjGGc23Ig&oe=6627C75A'),
                            ),
                            '  FicuFoide user'.text.bold.maxLines(2).make()
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child:
                                  "Cooking adobo is a traditional Filipino dish that's savory, tangy, and often served with rice."
                                      .text
                                      .overflow(TextOverflow.ellipsis)
                                      .make(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PopularWidgets extends StatefulWidget {
  const PopularWidgets({super.key});

  @override
  State<PopularWidgets> createState() => _PopularWidgetsState();
}

class _PopularWidgetsState extends State<PopularWidgets> {
  final List<String> imageUrls = [
    'https://www.cdc.gov/foodsafety/images/comms/features/GettyImages-520363077-medium.jpg?_=58727',
    'https://www.cdc.gov/foodsafety/images/comms/features/GettyImages-520363077-medium.jpg?_=58727',
    'https://www.cdc.gov/foodsafety/images/comms/features/GettyImages-520363077-medium.jpg?_=58727',
    'https://www.cdc.gov/foodsafety/images/comms/features/GettyImages-520363077-medium.jpg?_=58727',
    'https://www.cdc.gov/foodsafety/images/comms/features/GettyImages-520363077-medium.jpg?_=58727',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 10),
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            'Popular food'.text.bold.size(20).make(),
          ],
        ),
      ),
      SizedBox(height: 10),
      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: double.infinity,
        height: 150,
        child: CarouselSlider.builder(
          itemCount: imageUrls.length,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: false,
            enableInfiniteScroll: true,
          ),
          itemBuilder: (context, index, realIndex) {
            final imageUrl = imageUrls[index];
            return Container(
              margin: EdgeInsets.all(5.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ],);
  }
}

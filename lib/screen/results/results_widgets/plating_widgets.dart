import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PlatingWidgets extends StatefulWidget {
  const PlatingWidgets({super.key});

  @override
  State<PlatingWidgets> createState() => _PlatingWidgetsState();
}

class _PlatingWidgetsState extends State<PlatingWidgets> {
  final List<String> imageUrls = [
    'https://dadgotthis.com/wp-content/uploads/2019/09/Instant-Pot-Crispy-Chicken-Adobo-1440-960.jpg',
    'https://dadgotthis.com/wp-content/uploads/2019/09/Instant-Pot-Crispy-Chicken-Adobo-1440-960.jpg',
    'https://dadgotthis.com/wp-content/uploads/2019/09/Instant-Pot-Crispy-Chicken-Adobo-1440-960.jpg',
    'https://dadgotthis.com/wp-content/uploads/2019/09/Instant-Pot-Crispy-Chicken-Adobo-1440-960.jpg',
    'https://dadgotthis.com/wp-content/uploads/2019/09/Instant-Pot-Crispy-Chicken-Adobo-1440-960.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 5),
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            'Plating Images'.text.bold.size(20).make(),
          ],
        ),
      ),
      SizedBox(height: 5),
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
  }}

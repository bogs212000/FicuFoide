import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class StepsWidgets extends StatefulWidget {
  const StepsWidgets({super.key});

  @override
  State<StepsWidgets> createState() => _StepsWidgetsState();
}

class _StepsWidgetsState extends State<StepsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              'Instructions '.text.bold.size(20).make(),
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
          child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: ['Step 1'.text.bold.make()],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: "Cooking adobo is a traditional Filipino dish that's savory, tangy, and often served with rice. Here's a basic recipe and steps on how to cook adobo:"
                                  .text
                                  .overflow(TextOverflow.fade)
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

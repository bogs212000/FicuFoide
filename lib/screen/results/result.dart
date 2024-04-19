// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:ficufoide/cons/image.dart';
import 'package:ficufoide/screen/results/results_widgets/food_images.dart';
import 'package:ficufoide/screen/results/results_widgets/ingredients_list_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/plating_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/steps_widgets.dart';
import 'package:ficufoide/screen/results/results_widgets/users_suggest_widgets.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    'Name'.text.size(30).bold.make(),
                  ],
                ),
              ),
              //Intro
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Row(
                  children: [
                    Flexible(
                        child:
                            "Cooking adobo is a traditional Filipino dish that's savory, tangy, and often served with rice. Here's a basic recipe and steps on how to cook adobo:"
                                .text
                                .size(15)
                                .overflow(TextOverflow.fade)
                                .make()),
                  ],
                ),
              ),
              FoodImages(),
              IngredientsWidgets(),
              StepsWidgets(),
              UsersSuggestWidgets(),
              SizedBox(height: 10),
              PlatingWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}

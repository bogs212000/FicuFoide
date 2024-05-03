// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ficufoide/screen/home/home_widgets/popular.widget.dart';
import 'package:ficufoide/screen/home/home_widgets/topics.widget.dart';
import 'package:ficufoide/cons/image.dart';
import 'package:ficufoide/screen/results/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../fetch/fetch.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late File _image;
  late List _results;

  @override
  void initState() {
    // TODO: implement initState
    loadModel();
    fetchRole(setState);
    super.initState();
  }

  Future loadModel() async {
    Tflite.close();
    String res;

    res = (await Tflite.loadModel(
        model: "assets/image_model/model_unquant.tflite",
        labels: "assets/image_model/labels.txt"))!;
    print("Models loading status: $res");
  }

  //classify image
  Future classifyImage(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 1,
      threshold: 0.2,
      asynch: true,
    );

    // Check if recognitions list is not null and contains at least one recognition
    if (recognitions != null && recognitions.isNotEmpty) {
      // Get the first recognition result
      final recognition = recognitions[0];

      // Check if the confidence score of the recognition is below a certain threshold
      if (recognition['confidence'] < 0.6) {
        // Adjust the threshold as needed
        // Handle the case where recognition confidence is too low
        setState(() {
          resCon = 'low';
        });
        print(resCon);
      }

      // Update UI with recognition result
      setState(() {
        _results = recognitions;
        _image = image;
        resText = recognition['label'];
      });
      print('res: $_results');
      print(resText);
    } else {
      // Handle the case where no recognition results are available
      throw Exception('No recognition results available.');
    }
  }

  Future<void> _openImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedImage != null) {
      if (pickedImage != null) {
        File image = File(pickedImage.path);
        resultImage = File(pickedImage.path);
        await classifyImage(image);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(),
          ),
        );
      }
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      resultImage = File(pickedFile.path);
      await classifyImage(image);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int hours = DateTime.now().hour;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue, Colors.green],
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: 'Sign in'.text.color(Colors.white).make()),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: CachedNetworkImageProvider(
                                'https://t4.ftcdn.net/jpg/04/52/75/21/360_F_452752187_LCS2HVvLfrXDhpVmufmMZ5N6vNee8E0e.jpg'),
                          ),
                        ),
                        Spacer(),
                        hours >= 6 && hours <= 17
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset('assets/sun.png',
                                    height: 70, width: 70),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Image.asset('assets/sun.png',
                                    height: 70, width: 70),
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        'Hello '.text.size(30).color(Colors.white).bold.make(),
                        'User!'.text.size(30).color(Colors.white).bold.make()
                      ],
                    ),
                    Row(
                      children: [
                        'Welcome to FicuFoide '
                            .text
                            .size(25)
                            .color(Colors.white)
                            .make(),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 20),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Image.asset('assets/cook.png'),
                        ),
                      )),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                        child: "See recipe"
                                            .text
                                            .size(15)
                                            .bold
                                            .overflow(TextOverflow.fade)
                                            .make())
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: "Scan the food now!"
                                            .text
                                            .size(9)
                                            .overflow(TextOverflow.fade)
                                            .make())
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _openImagePicker();
                                    },
                                    child: Text('Camera'))),
                            SizedBox(height: 10),
                            SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                    onPressed: () {
                                      pickImage();
                                    },
                                    child: Text('Gallery'))),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              TopicsWidget(),
              PopularWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}

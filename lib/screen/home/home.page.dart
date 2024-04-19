// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
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
    super.initState();
  }
  Future loadModel() async {
    Tflite.close();
    String res;

    res = (await Tflite.loadModel(
        model: "assets/image_model/model_unquant.tflite", labels: "assets/image_model/labels.txt"))!;
    print("Models loading status: $res");
  }
  Future classifyImage(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 1,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _results = recognitions!;
      _image = image;
      resultImage = image;
      res = recognitions[0]['label'];
    });
    print(_results);
    print(res);
  }

  Future<void> _openImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedImage != null) {
      File image = File(pickedImage.path);

      classifyImage(image);
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);

      classifyImage(image);

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
                    EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 20),
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
                      children: [
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://scontent.fmnl4-6.fna.fbcdn.net/v/t39.30808-6/399241370_1591190431411220_8935650865096509315_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGuxWmxMpgGsTYYFKmR8slA7JHVzTxU4lnskdXNPFTiWaSctNiuHQyiWD62f190qE_ffxwFAUejfV1JNZ6on3FZ&_nc_ohc=qymh6IuFLEAAb7JKfu5&_nc_ht=scontent.fmnl4-6.fna&oh=00_AfC-2bRATbfyeE60FQdgiKBH3yjQNTWsFezfxg4j9-nJLg&oe=66279158'),
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
                        'Hello! '.text.size(30).color(Colors.white).bold.make(),
                        'Ednalyn'.text.size(30).color(Colors.white).bold.make()
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
                                    }, child: Text('Camera'))),
                            SizedBox(height: 10),
                            SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                    onPressed: () {
                                      pickImage();
                                    }, child: Text('Gallery'))),
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

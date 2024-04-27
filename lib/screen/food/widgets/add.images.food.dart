
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io';
import '../../../cons/image.dart';

class AddFoodImages extends StatefulWidget {
  const AddFoodImages({super.key});

  @override
  State<AddFoodImages> createState() => _AddFoodImagesState();
}

class _AddFoodImagesState extends State<AddFoodImages> {


  File? _image;

  late String imageUrl;

  final _picker = ImagePicker();
  late Future<List<String>> _imageUrls;

  @override
  void initState() {
    // TODO: implement initState
    _imageUrls = _getPictures();
    super.initState();
  }

  //get image list
  Future<List<String>> _getPictures() async {
    List<String> pictureUrls = [];
    try {
      Reference storageReference =
      FirebaseStorage.instance.ref().child(foodInfoPageDocName!);

      ListResult result = await storageReference.listAll();
      for (Reference ref in result.items) {
        String downloadUrl = await ref.getDownloadURL();
        pictureUrls.add(downloadUrl);
      }
    } catch (e) {
      print("Error retrieving pictures: $e");
      // Handle the error as needed
    }
    print(pictureUrls);
    return pictureUrls;
  }

  Future<void> _openImagePicker() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      // Upload the picked image to Firebase Storage
      String fileName = Uuid().v4();
      Reference storageReference = FirebaseStorage.instance.ref().child('$foodInfoPageDocName/$fileName');
      UploadTask uploadTask = storageReference.putFile(_image!);
      await uploadTask.whenComplete(() => print('Image uploaded'));

      // Once uploaded, you can retrieve the download URL if needed
      String imageUrl = await storageReference.getDownloadURL();

      // setState(() {
      //   loading = false;
      // });
    }
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
              'Images'.text.bold.size(20).make(),
              Spacer(),
              GestureDetector(
                child: Icon(Icons.add, color: Colors.grey),
                onTap: () {
                  _openImagePicker();
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(2),
          child: FutureBuilder<List<String>>(
            future: _imageUrls,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              List<String>? imageUrls = snapshot.data;
              if (imageUrls == null || imageUrls.isEmpty) {
                return Center(child: Text('No images yet!'));
              }
              return CarouselSlider.builder(
                itemCount: imageUrls.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(imageUrls[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

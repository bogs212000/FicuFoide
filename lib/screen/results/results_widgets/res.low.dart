import 'package:ficufoide/cons/image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ResLow extends StatefulWidget {
  const ResLow({super.key});

  @override
  State<ResLow> createState() => _ResLowState();
}

class _ResLowState extends State<ResLow> {
  @override
  void dispose() {
    resCon = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only( left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/ai.png'),
            'The image you captured or uploaded could not be identified by the app. Please try again.'
                .text
                .size(15)
                .make(),
            SizedBox(height: 20),
            'Note: The app is designed to identify food ingredients only.'
                .text
                .bold
                .make(),
            SizedBox(height: 100),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.green],
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back to home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

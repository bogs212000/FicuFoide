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
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/ai.png')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['Please try again.'.text.make()],
            )
          ],
        ),
      ),
    );
  }
}

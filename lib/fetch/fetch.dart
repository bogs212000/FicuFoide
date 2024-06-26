import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficufoide/cons/image.dart';

import '../cons/const.dart';
import '../cons/firebase.dart';
import '../cons/user.dart';

Future<void> fetchFoodName(Function setState) async {
  try {
    final snapshot =
    await FirebaseFirestore.instance.collection('foods').doc('$resText').get();

    setState(() {
      foodName = snapshot.data()?['foodName'];
      ingredientsRes =  snapshot.data()?['ingredients'];
      instructionsRes =  snapshot.data()?['instructions'];
      platingRes =  snapshot.data()?['plating'];
    });
    print('$foodName');
  } catch (e) {
    // Handle errors
  }
}

Future<void> fetchUsername(Function setState) async {
  try {
    final snapshot =
    await FirebaseFirestore.instance.collection('users').doc('$currentEmail').get();
    setState(() {
      username = snapshot.data()?['username'];
    });
    print('$username');
  } catch (e) {
    // Handle errors
  }
}

Future<void> fetchRole(Function setState) async {
  try {
    final snapshot =
    await FirebaseFirestore.instance.collection('users').doc(currentEmail).get();

    setState(() {
      role = snapshot.data()?['role'];
    });
    print('$role');
  } catch (e) {
    // Handle errors
  }
}

Future<void> fetchConfidence(Function setState) async {
  try {
    final snapshot =
    await FirebaseFirestore.instance.collection('settings').doc('confidence').get();

    setState(() {
      confidence = snapshot.data()?['confidence'];
    });
    print('$confidence');
  } catch (e) {
    // Handle errors
  }
}

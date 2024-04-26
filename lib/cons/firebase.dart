import 'package:firebase_auth/firebase_auth.dart';

String? currentEmail = FirebaseAuth.instance.currentUser!.email.toString();
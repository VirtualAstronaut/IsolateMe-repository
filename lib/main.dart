import 'package:covisolate0/AddWardInfo.dart';
import 'package:covisolate0/homepage.dart';
import 'package:covisolate0/loginscreen.dart';
import 'package:covisolate0/patient_register.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LoginScreen(),
    );
  }
}

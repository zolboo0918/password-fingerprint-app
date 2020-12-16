import 'package:flutter/material.dart';
import 'package:password_save_app/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password saver',
      home: Login(),
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        secondaryHeaderColor: Colors.white70,
        buttonColor: Colors.white60,
      ),
    );
  }
}

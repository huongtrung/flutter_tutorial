import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorial_flutter/pages/LandingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      theme: ThemeData(primaryColor: Colors.lightBlue),
    );
  }
}

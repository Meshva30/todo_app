import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/view/homescreen.dart';
import 'package:todo_app/view/loginscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loginscreen(),
    );
  }
}



import 'package:ai_chatboot/Pages/HomePage.dart';
import 'package:ai_chatboot/Pages/TestHomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestHomePage(),
    );
  }
}
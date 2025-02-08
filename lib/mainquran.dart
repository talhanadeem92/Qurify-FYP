import 'package:flutter/material.dart';
import 'package:my_flutter_app/splash_quran.dart';

import 'Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Splash(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
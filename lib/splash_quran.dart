import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:my_flutter_app/mmmmmmmm.dart';
// import 'package:my_flutter_app/prayer.dart';
// import 'package:my_flutter_app/quranbookmark112.dart';

// import 'Surahlist.dart';
// import 'Surahlist2.dart';
import 'bookmark1.dart';
import 'bookmark1111.dart';
// import 'quran_combined.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late BuildContext _context;
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(
          _context, MaterialPageRoute(builder: (context) =>  BookmarkManager()));
    }));
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset('assets/images/quran1.png'),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 69, 24, 7),
                    Color.fromARGB(255, 154, 102, 106)
                  ]),
            ),
          ),
        ),
        backgroundColor: Colors.brown[900]);
  }
}
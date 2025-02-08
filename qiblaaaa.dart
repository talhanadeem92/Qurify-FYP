import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double? _direction;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events?.listen((direction) {
      setState(() {
        _direction = direction as double?;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Qibla Compass",
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              left: 10,
              child: Text(
                "Qibla Compass",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset('assets/images/mosque.png'),
            ),
            Positioned(
              top: 100,
              left: 10,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Degree: ${_direction?.toInt() ?? 0}°",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text("---------------------"),
                  ],
                ),
              ),
            ),
            Center(
              child: Transform.rotate(
                angle: ((_direction ?? 0) * (math.pi / 180) * -1),
                child: Image.asset('assets/images/compass.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

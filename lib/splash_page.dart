
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/IntroPage.dart';

class SplashSecreen extends StatefulWidget
{
  @override
  State<SplashSecreen> createState() => _SplashSecreenState();
}

class _SplashSecreenState extends State<SplashSecreen> {
  @override
  void initState()
  {
    super.initState();
    Timer(Duration(seconds: 10),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     body: Container(
       color: Colors.blue,
       child: Center(
         child:Text("Classico",style: TextStyle(fontSize: 34,fontWeight: FontWeight.w700,color:Colors.white),)
       ),
     ),
   );
  }
}
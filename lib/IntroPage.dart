import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class IntroPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Center(child: Text("Intro")),
       ),
     ),
     body: Center(
       child: Column(
         children: [

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(child: Text("Welcome",style: TextStyle(fontSize: 31,fontWeight: FontWeight.w500),)),
           ),
         SizedBox(height: 11,),
           ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>CalculatorScreen()));},
               child: Text("Next")),
         ],
       ),
     ),
   );
  }

}
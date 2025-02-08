import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget
{ final String btnName;
  final Icon?icon;
  final Color? bgColor;
  final TextStyle?textStyle;
  final VoidCallback? callback;

RoundedButton(
{ required this.btnName, this.icon, this.bgColor=Colors.blue, this.textStyle, this.callback,});



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      callback!();
    }, child: Row());
  }

}
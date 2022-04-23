import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  String text;
  Color color;
  double height;
  double width;
  GestureTapCallback onTap;

  RoundedButton({this.text = "",this.color = Colors.green,this.height = 45,this.width = 120,required this.onTap});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
        ),
        child: Center(child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),)),
      ),
    );
  }
}

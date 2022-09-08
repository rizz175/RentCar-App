import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
  required this.onPressed,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    this.width,
     required this.height
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Color buttonColor;
  final  width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text,style: TextStyle(color: textColor,fontSize: 12),),
        style: ElevatedButton.styleFrom(
            primary: buttonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
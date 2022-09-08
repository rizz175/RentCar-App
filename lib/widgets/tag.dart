import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
   const Tag({
    this.color,
    required this.textColor,
     required this.text,
     required this.onTap,
  });

  final Color? color;
  final Color textColor;
  final String text;
   final VoidCallback onTap;


   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(right: 10,top: 5,bottom: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow:  [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              // offset: const Offset(
              //   10.0, // Move to right 10  horizontally
              //   10.0, // Move to bottom 10 Vertically
              // ),
            )
          ],
        ),
        child:  Center(child: Text(text,style: TextStyle(color: textColor),)),
      ),
    );
  }
}

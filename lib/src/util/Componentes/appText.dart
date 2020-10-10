import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final bool bold;

  AppText(
    this.text, {
    this.fontSize = 18,
    this.color = Colors.black,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle( 
        fontFamily: 'Cardo',
        fontSize: fontSize,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

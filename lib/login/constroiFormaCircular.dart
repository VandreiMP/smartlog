import 'package:flutter/material.dart';

class ConstroiFormaCircular extends StatelessWidget {
  const ConstroiFormaCircular({this.corPrimaria, this.corSecundaria});

  final Color corPrimaria;
  final Color corSecundaria;

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[300], Colors.blue[400]],
        ),
        borderRadius: BorderRadius.all(Radius.circular(500)),
      ),
    );
  }
}

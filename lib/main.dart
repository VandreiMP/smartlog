import 'package:flutter/material.dart';
import 'Components/login.dart';
import 'Components/body.dart';
import 'Components/menu/menu.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[100],
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          title: Text(
            'SmartLog',
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
        body: Row(
          children: <Widget>[Menu(), Body()],
        ),
      ),
    );
  }
}

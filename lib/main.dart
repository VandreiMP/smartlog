import 'package:flutter/material.dart';
import 'Components/body.dart';
import 'Components/menu/menu.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.blueGrey[100],
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('SmartLog', style: TextStyle(color: Colors.deepPurple),),
          ),
          body: Row(
            children: <Widget>[
              Menu(),
              Body()
            ],
          ),
        ));
  }
}

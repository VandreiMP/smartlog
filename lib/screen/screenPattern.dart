import 'package:flutter/material.dart';
import 'package:smartlogproject/Components/menu/menu.dart';

class ScreenPattern extends StatelessWidget {
  const ScreenPattern({
    this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey[800],
        title: Text(
          '/*SmartLog*/',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Row(
        children: <Widget>[
          Menu(),
          child,
        ],
      ),
    );
  }
}

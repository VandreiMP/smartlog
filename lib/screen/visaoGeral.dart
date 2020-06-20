import 'package:flutter/material.dart';
import 'package:smartlogproject/screen/screenPattern.dart';

class VisaoGeral extends StatefulWidget {
  @override
  _VisaoGeralState createState() => _VisaoGeralState();
}

class _VisaoGeralState extends State<VisaoGeral> {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
    );
  }
}

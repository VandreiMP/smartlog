import 'package:flutter/material.dart';
import 'package:smartlogproject/Components/body.dart';
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

import 'package:flutter/material.dart';
import 'package:smartlogproject/screen/visaoGeral.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => VisaoGeral()
      },
    );
  }
}

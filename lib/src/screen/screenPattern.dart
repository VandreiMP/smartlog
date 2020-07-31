import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartlogproject/src/Components/menu/menu.dart';
import 'package:smartlogproject/src/screen/Bloc/app-bar-bloc.dart';

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
        // actions: [
        //   BotaoSair(),
        // ],
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

class BotaoSair extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBarBloc blocAppBar = BlocProvider.of<AppBarBloc>(context);
    return StreamBuilder<Object>(
      stream: blocAppBar.outSairSistema,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GestureDetector(
          child: Icon(Icons.exit_to_app, color: Colors.white),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/menu/menu.dart';

/*
Modelo padrão de tela para o sistema
Usar este modelo para construir todos os formulários
*/

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

class BotaoSair extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.exit_to_app, color: Colors.white),
    );
  }
}

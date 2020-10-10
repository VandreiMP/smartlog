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
          automaticallyImplyLeading: false,
          elevation: 0.1,
          backgroundColor: Colors.blue[900],
          title: Row(
            children: [
              Text(
                'SMART',
                style: TextStyle(
                  fontFamily: 'Cardo',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'log - ',
                style: TextStyle(
                  height: 40,
                  fontFamily: 'Satisfy',
                  color: Colors.white,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'Solução para Controle Logístico de Aviários',
                style: TextStyle(
                  height: 40,
                  fontFamily: 'Cardo',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )),
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

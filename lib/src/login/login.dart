
import 'package:flutter/material.dart';

import 'constroiFormLogin.dart';
import 'constroiFormaCircular.dart';

/*
Componente depreciado. Foi criado um novo componente de Login.
*/

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: <Widget>[
          //aqui monta o fundo da tela (em tons crescentes de azul)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[100], Colors.blue[200], Colors.blue[700]],
              ),
            ),
          ),
          //aqui monta o primeiro círculo da tela (canto esquerdo)
          Positioned(
            right: 1100,
            top: 370,
            child: ConstroiFormaCircular(
                corPrimaria: Colors.blue[300], corSecundaria: Colors.blue[400]),
          ),
          //aqui monta o segundo círculo da tela (canto direito)
          Positioned(
            left: 1100,
            bottom: 370,
            child: ConstroiFormaCircular(
                corPrimaria: Colors.blue[300],
                corSecundaria: Colors.blueGrey[100]),
          ),
          //aqui monta o form com os campos para autenticação
          Positioned(
            right: 470.0,
            left: 470.0,
            bottom: 100.0,
            top: 100.0,
            child: ConstroiFormLogin(),
          ),
        ]),
      ),
    );
  }
}

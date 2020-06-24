import 'package:flutter/material.dart';

class ConstroiFormLogin extends StatelessWidget {
  const ConstroiFormLogin({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        gradient: LinearGradient(
          colors: [Colors.blueGrey[100], Colors.blue[100]],
        ),
      ),
      //aqui monta a coluna com os campos usuário/senha
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child:
              //ícone de autenticação
              Container(
            child: Icon(
              Icons.security,
              color: Colors.blueGrey[800],
              size: 60,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child:
              //texto de autenticação
              Container(
            child: Text(
              'Autenticação',
              style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
          child: constroiCampo(texto: 'Usuário', icone: Icons.person),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
          child: constroiCampo(texto: 'Senha', icone: Icons.vpn_key),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 140, right: 140),
          child:
              //botão de login
              Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(color: Colors.blueGrey[500], blurRadius: 1.5)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/VisaoGeral');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //icone de login
                    Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.blue[50],
                      ),
                    ),
                    //texto de login
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Liberar Acesso',
                        style: TextStyle(
                            color: Colors.blue[50],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget constroiCampo({String texto, IconData icone}) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.all(Radius.circular(40)),
        boxShadow: [BoxShadow(color: Colors.blueGrey[500], blurRadius: 1.5)],
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: texto,
          icon: Icon(icone),
        ),
      ),
    );
  }
}

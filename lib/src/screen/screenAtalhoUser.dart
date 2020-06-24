import 'package:flutter/material.dart';

import '../Components/scroll/scroll.dart';
import '../funcoes/criaCardAtalho.dart';
import 'screenPattern.dart';


class ScreenAtalhoCadastros extends StatefulWidget {
  @override
  _ScreenAtalhoCadastros createState() => _ScreenAtalhoCadastros();
}

class _ScreenAtalhoCadastros extends State<ScreenAtalhoCadastros> {
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
    return Scroll(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 4.0, left: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/FormularioUsuario');
                },
                child: CriaCardAtalho(
                  caminhoImagem: "Images/user_logo.png",
                  nomeFormulario: "Cadastro de Usuários",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/FormularioEmbalagem');
                },
                child: CriaCardAtalho(
                  caminhoImagem: "Images/embalagem.png",
                  nomeFormulario: "Cadastro de Embalagens",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/FormularioCaminhao');
                },
                child: CriaCardAtalho(
                  caminhoImagem: "Images/veiculo.png",
                  nomeFormulario: "Cadastro de Frota",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

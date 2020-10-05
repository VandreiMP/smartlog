import 'package:flutter/material.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';

class CriaCardAjudaRomaneio extends StatelessWidget {
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Container(
        alignment: Alignment.center,
        child: Card(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: new Border.all(
                color: Colors.black,
              ),
            ),
            padding: EdgeInsets.all(16),
            width: 320,
            child: Column(
              children: <Widget>[
                AppText(
                  '* Para salvar as alterações favor utilizar o botão do disquete.',
                  color: Colors.black,
                  bold: true,
                ),
                SizedBox(
                  height: 7.0,
                ),
                AppText(
                  '* Para retornar à página anterior favor utilizar a seta invertida.',
                  color: Colors.black,
                  bold: true,
                ),
                SizedBox(
                  height: 7.0,
                ),
                AppText(
                  '* Para gerar a rota de entrega da carga favor utilizar o botão ao lado da informação da cidade.',
                  color: Colors.black,
                  bold: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

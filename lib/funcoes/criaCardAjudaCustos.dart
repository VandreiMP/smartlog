import 'package:flutter/material.dart';
import 'package:smartlogproject/funcoes/appText.dart';

class CriaCardAjudaCustos extends StatelessWidget {
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
                  '* Quando o custo for do tipo fixo, o valor deve ser preenchido.',
                  color: Colors.black,
                  bold: true,
                ),
                SizedBox(
                  height: 7.0,
                ),
                AppText(
                  '* Os custos marcados como "Desconsidera" não serão levados para a Análise Gerencial.',
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

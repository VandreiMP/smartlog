import 'package:flutter/material.dart';

class CriaCardAtalho extends StatelessWidget {
  final String caminhoImagem;
  final String nomeFormulario;

  const CriaCardAtalho({this.caminhoImagem, this.nomeFormulario});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: Card(
          margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: new Border.all(
                color: Colors.black,
              ),
            ),
            padding: EdgeInsets.all(16),
            height: 320,
            width: 320,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
                      child: Image.asset(caminhoImagem),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      nomeFormulario,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/funcoes/appText.dart';
import 'package:smartlogproject/src/funcoes/buscaEmbalagens.dart';

class ListaValoresEmbalagem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider(
        bloc: EmbalagemBloc(context),
        child: CriaCardFormulario()),

    );
  }
}

class CriaCardFormulario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scroll(
      width: 800,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 2.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: new Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
            
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: AppText(
                        'Relação de Embalagens',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        BuscaEmbalagens(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
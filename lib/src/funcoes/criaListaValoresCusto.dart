import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/custo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/funcoes/appText.dart';
import 'package:smartlogproject/src/funcoes/buscaCustos.dart';
import 'package:smartlogproject/src/funcoes/buscaEmbalagens.dart';
import 'package:smartlogproject/src/screen/screenPattern.dart';

class ListaValoresCusto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: BlocProvider(
        bloc: CustoBloc(context),
        child: CriaCardFormulario(),
      ),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scroll(
      width: 720,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: 2.0,
            ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: AppText(
                            'Relação de Custos',
                            bold: true,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        BuscaCustos(Icons.add, 'LISTA_VALORES'),
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

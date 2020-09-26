import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/carregamentoMercadoria-bloc.dart';
import 'package:smartlogproject/src/funcoes/appText.dart';
import 'package:smartlogproject/src/funcoes/buscaCarregamentoMercadoria.dart';
import 'package:smartlogproject/src/funcoes/requiredLabel.dart';
import 'package:smartlogproject/src/screen/screenPattern.dart';

class ListaCargas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: BlocProvider(
        bloc: CarregamentoMercadoriaBloc(context),
        child: CriaCardFormulario(),
      ),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  final tComprador = TextEditingController();
  final tCarga = TextEditingController();

  bool inverteOrdenacao = false;

  @override
  Widget build(BuildContext context) {
    return Scroll(
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
                    Container(
                      child: AppText(
                        'Filtros para Consulta',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //height: 150.0,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: new Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: constroiCampo(
                                      labelCampo: 'Comprador',
                                      largura: 500,
                                      altura: 30,
                                      contextoAplicacao: context,
                                      obrigaCampo: false,
                                      controller: tComprador,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: constroiCampo(
                                          labelCampo: 'Carga',
                                          largura: 150,
                                          altura: 30,
                                          obrigaCampo: false,
                                          contextoAplicacao: context,
                                          controller: tCarga,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/FormularioCarga',
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 50.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: AppText(
                        'Lista de Cargas por Data de Entrega',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        BuscaCarregamentoMercadoria(),
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

  Widget constroiCampo(
      {String labelCampo,
      Function onChanged,
      double largura,
      double altura,
      bool obrigaCampo,
      BuildContext contextoAplicacao,
      TextEditingController mascara,
      TextEditingController controller}) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RequiredLabel(labelCampo, obrigaCampo),
          Container(
            height: altura,
            width: largura ?? double.maxFinite,
            child: TextFormField(
              maxLengthEnforced: true,
              cursorColor: Colors.black,
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

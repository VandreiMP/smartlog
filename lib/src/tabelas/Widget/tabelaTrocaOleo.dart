import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/caminhao-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/carregamentoMercadoria-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/custo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/empresa-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoAbastecimento-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoTrocaOleo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/constantes/mascaras.dart';
import 'package:smartlogproject/src/funcoes/appText.dart';
import 'package:smartlogproject/src/funcoes/buscaCaminhoes.dart';
import 'package:smartlogproject/src/funcoes/buscaCarregamentoMercadoria.dart';
import 'package:smartlogproject/src/funcoes/buscaCustos.dart';
import 'package:smartlogproject/src/funcoes/buscaEmbalagens.dart';
import 'package:smartlogproject/src/funcoes/buscaEmpresa.dart';
import 'package:smartlogproject/src/funcoes/buscaFuncionarios.dart';
import 'package:smartlogproject/src/funcoes/buscaSolicAbastecimento.dart';
import 'package:smartlogproject/src/funcoes/buscaTrocaOleo.dart';
import 'package:smartlogproject/src/funcoes/criaLista.dart';
import 'package:smartlogproject/src/funcoes/requiredLabel.dart';
import 'package:smartlogproject/src/screen/screenPattern.dart';
import 'package:smartlogproject/src/tabelas/Bloc/tabela-bloc.dart';

class ListaTrocaOleo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: BlocProvider(
        bloc: SolicitacaoTrocaOleoBloc(context),
        child: CriaCardFormulario(),
      ),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  final tId = TextEditingController();
  final tDataAbertura = TextEditingController();
  final tOficina = TextEditingController();

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
                                      labelCampo: 'Oficina',
                                      largura: 500,
                                      altura: 30,
                                      contextoAplicacao: context,
                                      obrigaCampo: false,
                                      controller: tOficina,
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
                                          labelCampo: 'Solicitação',
                                          largura: 150,
                                          altura: 30,
                                          obrigaCampo: false,
                                          contextoAplicacao: context,
                                          controller: tId,
                                          mascara: new MaskedTextController(
                                            mask: mascaraIdentificao,
                                          ),
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
                              '/FormularioTrocaDeOleo',
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
                        'Lista de Solicitações de Troca de Óleo Pendentes',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        BuscaTrocaOleo(),
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

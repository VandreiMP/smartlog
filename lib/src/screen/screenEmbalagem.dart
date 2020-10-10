import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/constantes/mascaras.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'package:smartlogproject/src/util/Componentes/requiredLabel.dart';
import 'package:smartlogproject/src/util/M%C3%A9todos%20de%20C%C3%A1lculo/calculaCubagem.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenEmbalagem extends StatefulWidget {
  @override
  _ScreenEmbalagem createState() => _ScreenEmbalagem();
}

class _ScreenEmbalagem extends State<ScreenEmbalagem> {
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
    return Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0),
      child: BlocProvider<EmbalagemBloc>(
        bloc: EmbalagemBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/embalagem.png",
                  nomeFormulario: "CADASTRO DE EMBALAGENS",
                  origem: 'EMBALAGEM',
                  origemDado: 'EMBALAGEM',
                  chaveConsulta: ModalRoute.of(context).settings.arguments,
                ),
                // CriaCardAjuda(),
              ],
            ),
            CriaCardFormulario()
          ],
        ),
      ),
    );
  }
}

class CriaCardFormulario extends StatefulWidget {
  @override
  _CriaCardFormularioState createState() => _CriaCardFormularioState();
}

class _CriaCardFormularioState extends State<CriaCardFormulario> {
  List<String> tipoEmbalagens = [
    'Forma',
    'Caixa',
    'Pallet',
  ];

  List<String> tipoCapacidade = [
    'Unidade/Ovo',
    'Quilo',
    'Grama',
    'Milheiro',
    'Tonelada',
  ];

  final tDescricao = TextEditingController();
  final tId = MaskedTextController(mask: mascaraIdentificao);
  final tCategoriaEmbalagem = TextEditingController();
  final tCapacidade = TextEditingController();
  final tTipoUnidade = TextEditingController();
  final tLargura = TextEditingController();
  final tComprimento = TextEditingController();
  final tAltura = TextEditingController();
  final tCubagem = TextEditingController();
  final tTara = TextEditingController();

  /*
  Variáveis de Controle para exibição das listas.
  */
  String valorSelecionadoUnidade;
  bool consultaListaUnidade = true;
  String valorSelecionadoCategoria;
  bool consultaListaCategoria = true;
  bool consultaFormulario = true;

  bool campoHabilitado = true;

  @override
  Widget build(BuildContext context) {
    String codigoEmbalagem = ModalRoute.of(context).settings.arguments;
    EmbalagemBloc blocEmbalagem = BlocProvider.of<EmbalagemBloc>(context);
    final Firestore firestore = Firestore.instance;

    void atualizaTipoUnidade(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          consultaFormulario = false;
          valorSelecionadoUnidade = valor;
          blocEmbalagem.setTipoUnidade(valorSelecionadoUnidade);
          consultaListaUnidade = false;
        });
      }
    }

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */

    void atualizaCategoria(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          consultaFormulario = false;
          valorSelecionadoCategoria = valor;
          blocEmbalagem.setcategoriaEmbalagem(valorSelecionadoCategoria);
          consultaListaCategoria = false;
        });
      }
    }

    Future consultaDados(DocumentSnapshot coluna) async {
      if (codigoEmbalagem.isNotEmpty) {
        tId.text = codigoEmbalagem;
      }
      tDescricao.text = coluna.data['descricao'];
      if (coluna.data['capacidade'] != null) {
        tCapacidade.text = coluna.data['capacidade'].toString();
      } else {
        tCapacidade.text = '0.00';
      }

      if (consultaListaUnidade == true) {
        tTipoUnidade.text = coluna.data['tipoUnidade'];
        atualizaTipoUnidade(tTipoUnidade.text);
      }
      if (consultaListaCategoria == true) {
        tCategoriaEmbalagem.text = coluna.data['categoriaEmbalagem'];
        atualizaCategoria(tCategoriaEmbalagem.text);
      }
      if (coluna.data['largura'] != null) {
        tLargura.text = coluna.data['largura'].toString();
      } else {
        tLargura.text = '0.00';
      }
      if (coluna.data['comprimento'] != null) {
        tComprimento.text = coluna.data['comprimento'].toString();
      } else {
        tComprimento.text = '0.00';
      }
      if (coluna.data['altura'] != null) {
        tAltura.text = coluna.data['altura'].toString();
      } else {
        tAltura.text = '0.00';
      }
      if (coluna.data['cubagem'] != null) {
        tCubagem.text = coluna.data['cubagem'].toString();
      } else {
        tCubagem.text = '0.00';
      }
      if (coluna.data['tara'] != null) {
        tTara.text = coluna.data['tara'].toString();
      } else {
        tTara.text = '0.00';
      }

      blocEmbalagem.setId(tId.text);
      blocEmbalagem.setDescricao(tDescricao.text);
      blocEmbalagem.setLargura(double.tryParse(tLargura.text));
      blocEmbalagem.setComprimento(double.tryParse(tComprimento.text));
      blocEmbalagem.setAltura(double.tryParse(tAltura.text));
      blocEmbalagem.setCubagem(double.tryParse(tCubagem.text));
      blocEmbalagem.setTara(double.tryParse(tTara.text));
    }

    if (codigoEmbalagem != null && consultaFormulario) {
      campoHabilitado = false;
      firestore
          .collection("embalagem")
          .document(codigoEmbalagem)
          .get()
          .then((coluna) async => consultaDados(coluna));
    }

    return StreamBuilder<Object>(
        stream: blocEmbalagem.outValorLista,
        builder: (context, snapshot) {
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
                              'Informações Gerais',
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
                                //height: 150.0,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: new Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: constroiCampo(
                                            labelCampo: 'Identificação',
                                            largura: 100,
                                            enabled: campoHabilitado,
                                            altura: 30,
                                            controller: tId,
                                            onChanged: (String valor) {
                                              blocEmbalagem.setId(tId.text);
                                            },
                                            obrigaCampo: true,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Descrição',
                                              largura: 500,
                                              altura: 30,
                                              obrigaCampo: true,
                                              controller: tDescricao,
                                              onChanged: (String valor) {
                                                blocEmbalagem.setDescricao(
                                                    tDescricao.text);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RequiredLabel(
                                                    'Categ.',
                                                    true,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 50.0,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            DropdownButton<
                                                                String>(
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Cardo',
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .black),
                                                              items:
                                                                  tipoEmbalagens
                                                                      .map((
                                                                String
                                                                    dropDownStringItem,
                                                              ) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value:
                                                                      dropDownStringItem,
                                                                  child: Text(
                                                                      dropDownStringItem),
                                                                );
                                                              }).toList(),
                                                              onChanged: (novoValorSelecionado) =>
                                                                  atualizaCategoria(
                                                                      novoValorSelecionado),
                                                              value:
                                                                  valorSelecionadoCategoria,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            child: AppText(
                              'Capacidade e Dimensões',
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
                                //height: 150.0,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: new Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: constroiCampo(
                                                labelCampo: 'Capacidade',
                                                largura: 71,
                                                altura: 30,
                                                controller: tCapacidade,
                                                onChanged: (String valor) =>
                                                    blocEmbalagem.setCapacidade(
                                                        double.tryParse(
                                                            tCapacidade.text)),
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RequiredLabel(
                                                    'Unidade',
                                                    false,
                                                  ),
                                                  Container(
                                                    height: 50.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        DropdownButton<String>(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cardo',
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.black),
                                                          items: tipoCapacidade
                                                              .map((
                                                            String
                                                                dropDownStringItem,
                                                          ) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  dropDownStringItem,
                                                              child: Text(
                                                                  dropDownStringItem),
                                                            );
                                                          }).toList(),
                                                          onChanged: (novoValorSelecionado) =>
                                                              atualizaTipoUnidade(
                                                                  novoValorSelecionado),
                                                          value:
                                                              valorSelecionadoUnidade,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerRight,
                                              child: constroiCampo(
                                                labelCampo: 'Largura',
                                                largura: 70,
                                                altura: 30,
                                                controller: tLargura,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setLargura(
                                                    double.tryParse(
                                                        tLargura.text),
                                                  );
                                                  tCubagem
                                                      .text = calculaCubagem(
                                                          double.tryParse(
                                                              tLargura.text),
                                                          double.tryParse(
                                                              tComprimento
                                                                  .text),
                                                          double.tryParse(
                                                              tAltura.text))
                                                      .toString();
                                                  blocEmbalagem.setCubagem(
                                                      double.tryParse(
                                                          tCubagem.text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '*',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                labelCampo: 'Compr.',
                                                largura: 70,
                                                altura: 30,
                                                controller: tComprimento,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setComprimento(
                                                      double.tryParse(
                                                          tComprimento.text));
                                                  tCubagem
                                                      .text = calculaCubagem(
                                                          double.tryParse(
                                                              tLargura.text),
                                                          double.tryParse(
                                                              tComprimento
                                                                  .text),
                                                          double.tryParse(
                                                              tAltura.text))
                                                      .toString();
                                                  blocEmbalagem.setCubagem(
                                                      double.tryParse(
                                                          tCubagem.text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '*',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                labelCampo: 'Altura',
                                                largura: 70,
                                                altura: 30,
                                                controller: tAltura,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setAltura(
                                                      double.tryParse(
                                                          tAltura.text));
                                                  tCubagem
                                                      .text = calculaCubagem(
                                                          double.tryParse(
                                                              tLargura.text),
                                                          double.tryParse(
                                                              tComprimento
                                                                  .text),
                                                          double.tryParse(
                                                              tAltura.text))
                                                      .toString();
                                                  blocEmbalagem.setCubagem(
                                                      double.tryParse(
                                                          tCubagem.text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '=',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                labelCampo: 'Cubagem',
                                                largura: 70,
                                                enabled: false,
                                                altura: 30,
                                                controller: tCubagem,
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                  labelCampo: 'Tara',
                                                  largura: 70,
                                                  altura: 30,
                                                  controller: tTara,
                                                  onChanged: (String valor) {
                                                    blocEmbalagem.setTara(
                                                        double.tryParse(
                                                            tTara.text));
                                                  },
                                                  obrigaCampo: false),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: AppText(
                              '*Os campos marcados com o asterisco são obrigatórios.',
                              color: Colors.red,
                              bold: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget constroiCampo({
    String labelCampo,
    Function onChanged,
    double largura,
    double altura,
    bool obrigaCampo,
    BuildContext contextoAplicacao,
    TextEditingController mascara,
    bool enabled,
    TextEditingController controller,
    String valorInicial,
  }) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RequiredLabel(labelCampo, obrigaCampo),
          Container(
            height: altura,
            width: largura ?? double.maxFinite,
            child: TextFormField(
              initialValue: valorInicial,
              cursorColor: Colors.black,
              enabled: enabled,
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontFamily: 'Cardo',
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(1, 0, 2, 10),
              ),
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

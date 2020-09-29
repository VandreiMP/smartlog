import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/funcoes/calculaCubagemEmbalagem.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
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
                  nomeFormulario: "Cadastro de Embalagens",
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
    'Ovo',
    'Forma',
    'Caixa',
  ];

  final tDescricao = TextEditingController();

  final tId = TextEditingController();

  final tCategoriaEmbalagem = TextEditingController();

  final tCapacidade = TextEditingController();

  final tTipoUnidade = TextEditingController();

  final tLargura = TextEditingController();

  final tComprimento = TextEditingController();

  final tAltura = TextEditingController();

  final tCubagem = TextEditingController();

  final tTara = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String codigoEmbalagem = ModalRoute.of(context).settings.arguments;
    EmbalagemBloc blocEmbalagem = BlocProvider.of<EmbalagemBloc>(context);
    final Firestore firestore = Firestore.instance;
    bool campoHabilitado = true;
    String valorSelecionado;

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */

    Future consultaDados(DocumentSnapshot coluna) async {
      if (codigoEmbalagem.isNotEmpty) {
        tId.text = codigoEmbalagem;
      }
      tDescricao.text = coluna.data['descricao'];
      tCapacidade.text = coluna.data['capacidade'].toString();
      tTipoUnidade.text = coluna.data['tipoUnidade'];
      print(tTipoUnidade.text);
      tLargura.text = coluna.data['largura'].toString();
      tComprimento.text = coluna.data['comprimento'].toString();
      tAltura.text = coluna.data['altura'].toString();
      tCubagem.text = coluna.data['cubagem'].toString();
      tTara.text = coluna.data['tara'].toString();

      blocEmbalagem.setId(tId.text);
      blocEmbalagem.setDescricao(tDescricao.text);
      blocEmbalagem.setCapacidade(double.parse(tCapacidade.text));
      blocEmbalagem.setTipoUnidade(valorSelecionado);
      blocEmbalagem.setLargura(double.parse(tLargura.text));
      blocEmbalagem.setComprimento(double.parse(tComprimento.text));
      blocEmbalagem.setAltura(double.parse(tAltura.text));
      blocEmbalagem.setCubagem(double.parse(tCubagem.text));
      blocEmbalagem.setTara(double.parse(tTara.text));
    }

    if (codigoEmbalagem != null) {
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RequiredLabel(
                                                    'Categ.',
                                                    true,
                                                  ),
                                                  Container(
                                                    child: DropDown(
                                                        valores:
                                                            tipoEmbalagens),
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
                                                largura: 100,
                                                altura: 30,
                                                controller: tCapacidade,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setCapacidade(
                                                      double.parse(
                                                          tCapacidade.text));
                                                },
                                                obrigaCampo: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RequiredLabel(
                                                    'Unidade',
                                                    true,
                                                  ),
                                                  StreamBuilder<Object>(
                                                      stream: blocEmbalagem
                                                          .outValorLista,
                                                      builder: (context,
                                                          retornoStream) {
                                                        Container(
                                                          height: 50.0,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              DropdownButton<
                                                                  String>(
                                                                items:
                                                                    tipoCapacidade
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
                                                                onChanged: (
                                                                  String
                                                                      novoValorSelecionado,
                                                                ) async {
                                                                  print(snapshot
                                                                      .data);
                                                                  blocEmbalagem
                                                                      .eventoAlteralista(
                                                                          novoValorSelecionado);
                                                                  valorSelecionado =
                                                                      novoValorSelecionado;
                                                                  blocEmbalagem
                                                                      .setTipoUnidade(
                                                                          novoValorSelecionado);
                                                                },
                                                                value:
                                                                    valorSelecionado,
                                                              ),
                                                            ],
                                                          ),
                                                        );

                                                        // return Container(
                                                        //   height: 50.0,
                                                        //   child: Column(
                                                        //     crossAxisAlignment:
                                                        //         CrossAxisAlignment
                                                        //             .center,
                                                        //     children: <Widget>[
                                                        //       DropdownButton<
                                                        //           String>(
                                                        //         items:
                                                        //             tipoCapacidade
                                                        //                 .map((
                                                        //           String
                                                        //               dropDownStringItem,
                                                        //         ) {
                                                        //           return DropdownMenuItem<
                                                        //               String>(
                                                        //             value:
                                                        //                 dropDownStringItem,
                                                        //             child: Text(
                                                        //                 dropDownStringItem),
                                                        //           );
                                                        //         }).toList(),
                                                        //         onChanged: (
                                                        //           String
                                                        //               novoValorSelecionado,
                                                        //         ) async {
                                                        //           print(snapshot
                                                        //               .data);
                                                        //           blocEmbalagem
                                                        //               .eventoAlteralista(
                                                        //                   novoValorSelecionado);
                                                        //           valorSelecionado =
                                                        //               novoValorSelecionado;
                                                        //           blocEmbalagem
                                                        //               .setTipoUnidade(
                                                        //                   novoValorSelecionado);
                                                        //         },
                                                        //         value:
                                                        //             valorSelecionado,
                                                        //       ),
                                                        //     ],
                                                        //   ),
                                                        // );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            // StreamBuilder<Object>(
                                            //   initialData: false,
                                            //   stream:
                                            //       blocEmbalagem.outValorLista,
                                            //   builder: (BuildContext context,
                                            //       AsyncSnapshot snapshot) {
                                            //     return Padding(
                                            //       padding:
                                            //           const EdgeInsets.only(
                                            //               top: 10.0),
                                            //       child: Container(
                                            //         alignment:
                                            //             Alignment.centerLeft,
                                            //         child: Checkbox(
                                            //           visualDensity:
                                            //               VisualDensity(
                                            //                   horizontal: 2.0,
                                            //                   vertical: 2.0),
                                            //           value: snapshot.data,
                                            //           onChanged:
                                            //               (bool novoValor) {
                                            //             blocAcesso
                                            //                 .eventoCliqueCheckBox(
                                            //                     novoValor,
                                            //                     tSenha);
                                            //             escondeSenha =
                                            //                 snapshot.data;
                                            //           },
                                            //         ),
                                            //       ),
                                            //     );
                                            //   },
                                            // ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: constroiCampo(
                                                  labelCampo: 'Largura',
                                                  largura: 70,
                                                  altura: 30,
                                                  controller: tLargura,
                                                  onChanged: (String valor) {
                                                    blocEmbalagem.setLargura(
                                                      double.parse(
                                                          tLargura.text),
                                                    );
                                                    tCubagem.text =
                                                        calculaCubagemEmbalagem(
                                                                double.parse(
                                                                    tLargura
                                                                        .text),
                                                                double.parse(
                                                                    tComprimento
                                                                        .text),
                                                                double.parse(
                                                                    tAltura
                                                                        .text))
                                                            .toString();
                                                    blocEmbalagem.setCubagem(
                                                        double.parse(
                                                            tCubagem.text));
                                                  },
                                                  obrigaCampo: false,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                labelCampo: 'Comprimento',
                                                largura: 70,
                                                altura: 30,
                                                controller: tComprimento,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setComprimento(
                                                      double.parse(
                                                          tComprimento.text));
                                                  tCubagem.text =
                                                      calculaCubagemEmbalagem(
                                                              double.parse(
                                                                  tLargura
                                                                      .text),
                                                              double.parse(
                                                                  tComprimento
                                                                      .text),
                                                              double.parse(
                                                                  tAltura.text))
                                                          .toString();
                                                  blocEmbalagem.setCubagem(
                                                      double.parse(
                                                          tCubagem.text));
                                                },
                                                obrigaCampo: false,
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
                                                      double.parse(
                                                          tAltura.text));
                                                  tCubagem.text =
                                                      calculaCubagemEmbalagem(
                                                              double.parse(
                                                                  tLargura
                                                                      .text),
                                                              double.parse(
                                                                  tComprimento
                                                                      .text),
                                                              double.parse(
                                                                  tAltura.text))
                                                          .toString();
                                                  blocEmbalagem.setCubagem(
                                                      double.parse(
                                                          tCubagem.text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                labelCampo: 'Cubagem',
                                                largura: 70,
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
                                                        double.parse(
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
    //int tamanhoMaximo,
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

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/custo-bloc.dart';
import 'package:smartlogproject/src/constantes/mascaras.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'package:smartlogproject/src/util/Componentes/requiredLabel.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenCustos extends StatefulWidget {
  @override
  _ScreenCustos createState() => _ScreenCustos();
}

class _ScreenCustos extends State<ScreenCustos> {
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
      child: BlocProvider<CustoBloc>(
        bloc: CustoBloc(context),
        child: Row(
          children: <Widget>[
            Scroll(
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CriaCardAuxiliar(
                    caminhoImagem: "Images/money.png",
                    nomeFormulario: "CONTROLE DE CUSTOS",
                    origem: 'CUSTOS',
                    origemDado: 'CUSTOS',
                    chaveConsulta: ModalRoute.of(context).settings.arguments,
                  ),
                  // CriaCardAjuda(),
                ],
              ),
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
  List<String> modalidadeCusto = [
    'Fixo',
    'Variável',
  ];

  List<String> periodoCusto = [
    'Semanal',
    'Quinzenal',
    'Mensal',
    'Trimestral',
    'Semestral',
    'Anual',
    'Não se Aplica',
  ];

  List<String> consideraAgr = [
    'Considera',
    'Desconsidera',
  ];

  /*
  Variáveis usadas para capturar o valor dos campos do formulário
  e salvar no banco
  */

  final tDetalhes = TextEditingController();
  final tId = MaskedTextController(mask: mascaraIdentificao);
  final tModalidade = TextEditingController();
  final tPeriodicidade = TextEditingController();
  final tAnaliseGerencial = TextEditingController();
  final tValor = TextEditingController();
  bool campoHabilitado = true;
  /*
  Variáveis de Controle para exibição das listas.
  */
  String valorModalidadeCusto;
  bool consultaModalidadeCusto = true;
  String valorPeriodoCusto;
  bool consultaPeriodoCusto = true;
  String valorAgr;
  bool consultaAgr = true;

  bool consultaFormulario = true;

  @override
  Widget build(BuildContext context) {
    CustoBloc blocCusto = BlocProvider.of<CustoBloc>(context);
    final Firestore firestore = Firestore.instance;
    String identificacaoCusto = ModalRoute.of(context).settings.arguments;

    void atualizaModalidadeCusto(String valor) {
      if (valor.isNotEmpty) {
        consultaFormulario = false;
        setState(() {
          valorModalidadeCusto = valor;
          blocCusto.setModalidade(valorModalidadeCusto);
          consultaModalidadeCusto = false;
        });
      }
    }

    void atualizaPeriodoCusto(String valor) {
      if (valor.isNotEmpty) {
        consultaFormulario = false;
        setState(() {
          valorPeriodoCusto = valor;
          blocCusto.setPeriodicidade(valorPeriodoCusto);
          consultaPeriodoCusto = false;
        });
      }
    }

    void atualizaAgr(String valor) {
      if (valor.isNotEmpty) {
        consultaFormulario = false;
        setState(() {
          valorAgr = valor;
          blocCusto.setAnaliseGerencial(valorAgr);
          consultaAgr = false;
        });
      }
    }

    Future consultaValor(DocumentSnapshot coluna) async {
      if (identificacaoCusto.isNotEmpty) {
        tId.text = identificacaoCusto;
      }
      tDetalhes.text = coluna.data['detalhes'];
      if (coluna.data['valor'] != null) {
        tValor.text = coluna.data['valor'].toString();
      } else {
        tValor.text = '0.00';
      }
      if (consultaModalidadeCusto == true) {
        tModalidade.text = coluna.data['modalidade'];
        atualizaModalidadeCusto(tModalidade.text);
      }

      if (consultaPeriodoCusto == true) {
        tPeriodicidade.text = coluna.data['periodicidade'];
        atualizaPeriodoCusto(tPeriodicidade.text);
      }

      if (consultaAgr == true) {
        tAnaliseGerencial.text = coluna.data['analiseGerencial'];
        atualizaAgr(tAnaliseGerencial.text);
      }

      blocCusto.setId(tId.text);
      blocCusto.setDetalhes(tDetalhes.text);
      blocCusto.setValor(double.tryParse(tValor.text));
    }

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */
    if (identificacaoCusto != null && consultaFormulario) {
      campoHabilitado = false;
      firestore
          .collection("custos")
          .document(identificacaoCusto)
          .get()
          .then((coluna) async => consultaValor(coluna));
    }

    return StreamBuilder<QuerySnapshot>(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              'Custos',
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
                                              alignment: Alignment.topLeft,
                                              child: constroiCampo(
                                                labelCampo: 'Identificação',
                                                largura: 150,
                                                enabled: campoHabilitado,
                                                altura: 30,
                                                controller: tId,
                                                obrigaCampo: true,
                                                onChanged: (String valor) {
                                                  blocCusto.setId(tId.text);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: constroiCampo(
                                                  labelCampo: 'Detalhes',
                                                  largura: 250,
                                                  controller: tDetalhes,
                                                  altura: 30,
                                                  onChanged: (String valor) {
                                                    blocCusto.setDetalhes(
                                                        tDetalhes.text);
                                                  },
                                                  obrigaCampo: true,
                                                ),
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
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    RequiredLabel(
                                                      'Modalidade',
                                                      true,
                                                    ),
                                                    Container(
                                                      height: 50.0,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
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
                                                                modalidadeCusto
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
                                                                atualizaModalidadeCusto(
                                                                    novoValorSelecionado),
                                                            value:
                                                                valorModalidadeCusto,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      RequiredLabel(
                                                        'Periodicidade',
                                                        true,
                                                      ),
                                                      Container(
                                                        height: 50.0,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            DropdownButton<
                                                                    String>(
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Cardo',
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .black),
                                                                items:
                                                                    periodoCusto
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
                                                                onChanged:
                                                                    (novoValorSelecionado) =>
                                                                        atualizaPeriodoCusto(
                                                                            novoValorSelecionado),
                                                                value:
                                                                    valorPeriodoCusto),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RequiredLabel(
                                                          'Análise Gerencial',
                                                          true,
                                                        ),
                                                        Container(
                                                          height: 50.0,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              DropdownButton<
                                                                      String>(
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Cardo',
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .black),
                                                                  items:
                                                                      consideraAgr
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
                                                                  onChanged:
                                                                      (novoValorSelecionado) =>
                                                                          atualizaAgr(
                                                                              novoValorSelecionado),
                                                                  value:
                                                                      valorAgr),
                                                            ],
                                                          ),
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
                                              alignment: Alignment.topLeft,
                                              child: constroiCampo(
                                                labelCampo: 'Valor',
                                                largura: 80,
                                                controller: tValor,
                                                altura: 30,
                                                onChanged: (String valor) {
                                                  blocCusto.setValor(
                                                      double.tryParse(
                                                          tValor.text));
                                                },
                                                obrigaCampo: false,
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
              controller: controller,
              onChanged: onChanged,
              enabled: enabled,
              style: TextStyle(
                fontFamily: 'Cardo',
                fontSize: 17,
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

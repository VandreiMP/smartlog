import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoAbastecimento-bloc.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'package:smartlogproject/src/util/Componentes/appTextField.dart';
import 'package:smartlogproject/src/util/Componentes/requiredLabel.dart';
import 'package:smartlogproject/src/util/Listas%20de%20Valores/criaListaValoresCusto.dart';
import 'package:smartlogproject/src/util/M%C3%A9todos%20de%20C%C3%A1lculo/calculaCustoSolicitacao.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenAbastecimento extends StatefulWidget {
  @override
  _ScreenAbastecimentoState createState() => _ScreenAbastecimentoState();
}

class _ScreenAbastecimentoState extends State<ScreenAbastecimento> {
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0),
      child: BlocProvider<SolicitacaoAbastecimentoBloc>(
        bloc: SolicitacaoAbastecimentoBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/combustivel.png",
                  nomeFormulario: "Programação de Abastecimento",
                  origem: 'COMBUSTIVEL',
                  origemDado: 'COMBUSTIVEL',
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
  List<String> situacaoSolicitacao = [
    'Aberta',
    'Negada',
    'Efetivada',
  ];

  List<String> tipoCombustivel = [
    'Diesel',
    'Gasolina',
    'Etanol',
    'Flex',
    'GLP',
    'Outros'
  ];
  /*
    Variáveis usadas para capturar o valor dos campos do formulário
    e salvar no banco
  */
  final tDetalhes = TextEditingController();
  final tId = TextEditingController();
  final tSituacao = TextEditingController();
  final tSolicitante = TextEditingController();
  final tDataAbertura = TextEditingController();
  final tDataEfetivacao = TextEditingController();
  final tPosto = TextEditingController();
  final tTipoCombustivel = TextEditingController();
  final tPrecoLitro = TextEditingController();
  final tQuantidade = TextEditingController();
  final tCustoTotal = TextEditingController();
  final tCustoVinculado = TextEditingController();
  final tDsCusto = TextEditingController();

  /*
  Variáveis de Controle para exibição das listas.
  */
  String valorSituacaoProg = 'Aberta';
  bool consultaSituacaoProg = true;
  String valorTipoCombustivel;
  bool consultaTipoCombustivel = true;

  bool preencheDadosIniciais = true;

  @override
  Widget build(BuildContext context) {
    SolicitacaoAbastecimentoBloc blocSolicitacaoAbastecimento =
        BlocProvider.of<SolicitacaoAbastecimentoBloc>(context);
    String codigoSolicitacao = ModalRoute.of(context).settings.arguments;
    final Firestore firestore = Firestore.instance;
    bool campoHabilitado = true;

    final DateFormat formataData = DateFormat('dd/MM/yyyy H:mm');

    if (codigoSolicitacao != null) {
      preencheDadosIniciais = false;
    }

    if (codigoSolicitacao == null ||
        (codigoSolicitacao != 'NULO' && preencheDadosIniciais == true)) {
      tDataAbertura.text = formataData.format(DateTime.now());
      blocSolicitacaoAbastecimento.setDataAbertura(tDataAbertura.text);
    }
    void atualizaSituacaoProg(String valor, String origem) {
      if (valor.isNotEmpty) {
        setState(() {
          valorSituacaoProg = valor;
          blocSolicitacaoAbastecimento
              .setSituacaoSolicitacao(valorSituacaoProg);
          consultaSituacaoProg = false;
          if (origem == 'BOTAO') {
            if (valorSituacaoProg == 'Efetivada') {
              tDataEfetivacao.text = formataData.format(DateTime.now());
              blocSolicitacaoAbastecimento
                  .setDataEfetivacao(tDataEfetivacao.text);
            } else if (valorSituacaoProg == 'Negada') {
              tDataEfetivacao.text = formataData.format(DateTime.now());
              blocSolicitacaoAbastecimento
                  .setDataEfetivacao(tDataEfetivacao.text);
            }
          }
        });
      }
    }

    void atualizaTipoCombustivel(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          valorTipoCombustivel = valor;
          blocSolicitacaoAbastecimento.setCombustivel(valorTipoCombustivel);
          consultaTipoCombustivel = false;
        });
      }
    }

    void consultaCusto() async {
      firestore
          .collection("custos")
          .document(tCustoVinculado.text)
          .get()
          .then((value) async => tDsCusto.text = value.data['detalhes']);
    }

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */

    Future consultaDados(DocumentSnapshot coluna) async {
      if (codigoSolicitacao.isNotEmpty) {
        tId.text = codigoSolicitacao;
      }
      tDetalhes.text = coluna.data['detalhes'];
      tSolicitante.text = coluna.data['solicitante'];
      tDataAbertura.text = coluna.data['dataAbertura'];

      tPosto.text = coluna.data['posto'];
      tPrecoLitro.text = coluna.data['precoLitro'].toString();
      tQuantidade.text = coluna.data['quantidade'].toString();
      tCustoTotal.text = coluna.data['custoTotal'].toString();
      tCustoVinculado.text = coluna.data['custoVinculado'];

      if (consultaTipoCombustivel == true) {
        tTipoCombustivel.text = coluna.data['tipoCombustivel'];
        atualizaTipoCombustivel(tTipoCombustivel.text);
      }

      if (consultaSituacaoProg == true) {
        preencheDadosIniciais = false;
        tSituacao.text = coluna.data['situacaoSolicitacao'];
        atualizaSituacaoProg(tSituacao.text, 'CONSULTA');
        tDataEfetivacao.text = coluna.data['dataEfetivacao'];
        blocSolicitacaoAbastecimento.setDataEfetivacao(tDataEfetivacao.text);
      }

      consultaCusto();

      blocSolicitacaoAbastecimento.setId(tId.text);
      blocSolicitacaoAbastecimento.setDetalhes(tDetalhes.text);
      blocSolicitacaoAbastecimento.setSolicitante(tSolicitante.text);
      blocSolicitacaoAbastecimento.setDataAbertura(tDataAbertura.text);

      blocSolicitacaoAbastecimento.setPosto(tPosto.text);
      blocSolicitacaoAbastecimento
          .setPrecoLitro(double.tryParse(tPrecoLitro.text));
      blocSolicitacaoAbastecimento
          .setQuantidade(double.tryParse(tQuantidade.text));
      blocSolicitacaoAbastecimento
          .setCustoTotal(double.tryParse(tCustoTotal.text));
    }

    if (codigoSolicitacao != null) {
      campoHabilitado = false;
      firestore
          .collection("solicitacaoAbastecimento")
          .document(codigoSolicitacao)
          .get()
          .then((coluna) async => consultaDados(coluna));
    }

    return StreamBuilder<QuerySnapshot>(
        stream: null,
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
                              'Cabeçalho',
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
                                          children: [
                                            Container(
                                              child: constroiCampo(
                                                labelCampo: 'Identificação',
                                                largura: 150,
                                                altura: 30,
                                                enabled: campoHabilitado,
                                                obrigaCampo: true,
                                                controller: tId,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setId(tId.text);
                                                },
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
                                                labelCampo: 'Detalhes',
                                                largura: 500,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tDetalhes,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setDetalhes(
                                                          tDetalhes.text);
                                                },
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
                                                    'Situação',
                                                    false,
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
                                                        DropdownButton<String>(
                                                            items:
                                                                situacaoSolicitacao
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
                                                            onChanged: (String
                                                                novoValorSelecionado) {},
                                                            value:
                                                                valorSituacaoProg),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 14.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              preencheDadosIniciais =
                                                                  false;
                                                              blocSolicitacaoAbastecimento
                                                                  .verificaAlteracaoSituacao(
                                                                      tId.text,
                                                                      context,
                                                                      'EFETIVAR')
                                                                  .then((mensagemRetorno) => mensagemRetorno ==
                                                                          'OK'
                                                                      ? atualizaSituacaoProg(
                                                                          'Efetivada',
                                                                          'BOTAO')
                                                                      : null);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          2.0),
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              blocSolicitacaoAbastecimento
                                                                  .verificaAlteracaoSituacao(
                                                                      tId.text,
                                                                      context,
                                                                      'NEGAR')
                                                                  .then((mensagemRetorno) => mensagemRetorno ==
                                                                          'OK'
                                                                      ? atualizaSituacaoProg(
                                                                          'Negada',
                                                                          'BOTAO')
                                                                      : null);
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          2.0),
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons.cancel,
                                                                size: 25.0,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                                                  labelCampo: 'Solicitante',
                                                  largura: 350,
                                                  altura: 30,
                                                  obrigaCampo: true,
                                                  controller: tSolicitante,
                                                  onChanged: (String valor) {
                                                    blocSolicitacaoAbastecimento
                                                        .setSolicitante(
                                                            tSolicitante.text);
                                                  }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Data Abertura',
                                                largura: 140,
                                                altura: 30,
                                                enabled: false,
                                                obrigaCampo: true,
                                                controller: tDataAbertura,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Data Encerramento',
                                                largura: 140,
                                                altura: 30,
                                                enabled: false,
                                                obrigaCampo: false,
                                                controller: tDataEfetivacao,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setDataEfetivacao(
                                                          tDataEfetivacao.text);
                                                },
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
                              'Informações do Abastecimento',
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
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              constroiCampo(
                                                labelCampo: 'Posto',
                                                largura: 500,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tPosto,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setPosto(tPosto.text);
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
                                                      'Combustível',
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
                                                            items:
                                                                tipoCombustivel
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
                                                                atualizaTipoCombustivel(
                                                                    novoValorSelecionado),
                                                            value:
                                                                valorTipoCombustivel,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: constroiCampo(
                                                labelCampo: 'Preço p/ Litro',
                                                largura: 85,
                                                altura: 30,
                                                controller: tPrecoLitro,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setPrecoLitro(
                                                          double.tryParse(
                                                              tPrecoLitro
                                                                  .text));
                                                  tCustoTotal.text =
                                                      calculaValorTotalSolicitacao(
                                                    double.tryParse(
                                                        tPrecoLitro.text),
                                                    double.tryParse(
                                                        tQuantidade.text),
                                                  ).toString();
                                                  blocSolicitacaoAbastecimento
                                                      .setCustoTotal(
                                                          double.tryParse(
                                                              tCustoTotal
                                                                  .text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '   *',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Quantidade(Lt)',
                                                largura: 85,
                                                altura: 30,
                                                controller: tQuantidade,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setQuantidade(
                                                          double.tryParse(
                                                              tQuantidade
                                                                  .text));
                                                  blocSolicitacaoAbastecimento
                                                      .setCustoTotal(
                                                          double.tryParse(
                                                              tCustoTotal
                                                                  .text));
                                                  tCustoTotal.text =
                                                      calculaValorTotalSolicitacao(
                                                    double.tryParse(
                                                        tPrecoLitro.text),
                                                    double.tryParse(
                                                        tQuantidade.text),
                                                  ).toString();
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '   =',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Custo Total',
                                                largura: 85,
                                                altura: 30,
                                                controller: tCustoTotal,
                                                obrigaCampo: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            constroiCampo(
                                              labelCampo: 'Custo Vinculado',
                                              largura: 450,
                                              altura: 30,
                                              controller: tDsCusto,
                                              enabled: false,
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        tCustoVinculado.text =
                                                            '';
                                                        tDsCusto.text = '';
                                                        blocSolicitacaoAbastecimento
                                                            .setCustoVinculado(
                                                                tCustoVinculado
                                                                    .text);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 25.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () async {
                                                        tCustoVinculado
                                                            .text = await Navigator
                                                                .of(context)
                                                            .push(
                                                                PageRouteBuilder(
                                                          opaque: false,
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              ListaValoresCusto(),
                                                        ));

                                                        if (tCustoVinculado
                                                            .text.isNotEmpty) {
                                                          firestore
                                                              .collection(
                                                                  "custos")
                                                              .document(
                                                                  tCustoVinculado
                                                                      .text)
                                                              .get()
                                                              .then((value) async =>
                                                                  tDsCusto
                                                                      .text = value
                                                                          .data[
                                                                      'detalhes']);
                                                          blocSolicitacaoAbastecimento
                                                              .setCustoVinculado(
                                                                  tCustoVinculado
                                                                      .text);
                                                        }
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.blue[900],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.attach_money,
                                                          size: 25.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
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
                          SizedBox(
                            height: 10,
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
    double largura,
    double altura,
    bool obrigaCampo,
    Function onChanged,
    bool enabled,
    TextEditingController controller,
  }) {
    return Form(
      child: AppTextField(
        label: labelCampo,
        onChanged: onChanged,
        width: largura,
        enabled: enabled,
        heigth: altura,
        required: obrigaCampo,
        controller: controller,
      ),
    );
  }
}

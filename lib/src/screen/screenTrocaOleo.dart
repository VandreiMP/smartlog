import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoTrocaOleo-bloc.dart';
import 'package:smartlogproject/src/funcoes/appTextField.dart';
import 'package:smartlogproject/src/funcoes/calculaCustoSolicitacao.dart';
import 'package:smartlogproject/src/funcoes/criaListaValoresCusto.dart';
import '../funcoes/appText.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

class ScreenTrocaOleo extends StatefulWidget {
  @override
  _ScreenTrocaOleoState createState() => _ScreenTrocaOleoState();
}

class _ScreenTrocaOleoState extends State<ScreenTrocaOleo> {
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
      child: BlocProvider<SolicitacaoTrocaOleoBloc>(
        bloc: SolicitacaoTrocaOleoBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/oleo.png",
                  nomeFormulario: "Programação de Troca de Óleo",
                  origem: 'OLEO',
                  origemDado: 'OLEO',
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
    'Pendente',
    'Negada',
    'Efetivada',
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
  final tOficina = TextEditingController();
  final tFornecedor = TextEditingController();
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
    SolicitacaoTrocaOleoBloc blocSolicitacaoTrocaOleo =
        BlocProvider.of<SolicitacaoTrocaOleoBloc>(context);

    String codigoSolicitacao = ModalRoute.of(context).settings.arguments;
    final Firestore firestore = Firestore.instance;
    bool campoHabilitado = true;

    final DateFormat formataData = DateFormat('dd/MM/yyyy H:m');

    if (codigoSolicitacao != null) {
      preencheDadosIniciais = false;
    }

    if (codigoSolicitacao == null ||
        (codigoSolicitacao != 'NULO' && preencheDadosIniciais == true)) {
      tDataAbertura.text = formataData.format(DateTime.now());
      blocSolicitacaoTrocaOleo.setDataAbertura(tDataAbertura.text);
    }
    void atualizaSituacaoProg(String valor, String origem) {
      if (valor.isNotEmpty) {
        setState(() {
          valorSituacaoProg = valor;
          blocSolicitacaoTrocaOleo.setSituacaoSolicitacao(valorSituacaoProg);
          consultaSituacaoProg = false;
          if (origem == 'BOTAO') {
            if (valorSituacaoProg == 'Efetivada') {
              tDataEfetivacao.text = formataData.format(DateTime.now());
              blocSolicitacaoTrocaOleo.setDataEfetivacao(tDataEfetivacao.text);
            } else if (valorSituacaoProg == 'Negada') {
              tDataEfetivacao.text = formataData.format(DateTime.now());
              blocSolicitacaoTrocaOleo.setDataEfetivacao(tDataEfetivacao.text);
            }
          }
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
      tOficina.text = coluna.data['oficina'];
      tFornecedor.text = coluna.data['fornecedor'];
      tPrecoLitro.text = coluna.data['precoLitro'].toString();
      tQuantidade.text = coluna.data['quantidade'].toString();
      tCustoTotal.text = coluna.data['custoTotal'].toString();
      tCustoTotal.text = coluna.data['custoVinculado'];

      if (consultaSituacaoProg == true) {
        preencheDadosIniciais = false;
        tSituacao.text = coluna.data['situacaoSolicitacao'];
        atualizaSituacaoProg(tSituacao.text, 'CONSULTA');
        tDataEfetivacao.text = coluna.data['dataEfetivacao'];
        blocSolicitacaoTrocaOleo.setDataEfetivacao(tDataEfetivacao.text);
      }

      consultaCusto();

      blocSolicitacaoTrocaOleo.setId(tId.text);
      blocSolicitacaoTrocaOleo.setDetalhes(tDetalhes.text);
      blocSolicitacaoTrocaOleo.setSolicitante(tSolicitante.text);
      blocSolicitacaoTrocaOleo.setDataAbertura(tDataAbertura.text);
      blocSolicitacaoTrocaOleo.setOficina(tOficina.text);
      blocSolicitacaoTrocaOleo.setFornecedor(tFornecedor.text);
      blocSolicitacaoTrocaOleo.setPrecoLitro(double.tryParse(tPrecoLitro.text));
      blocSolicitacaoTrocaOleo.setQuantidade(double.tryParse(tQuantidade.text));
      blocSolicitacaoTrocaOleo.setCustoTotal(double.tryParse(tCustoTotal.text));
      blocSolicitacaoTrocaOleo.setCustoVinculado(tCustoTotal.text);
    }

    if (codigoSolicitacao != null) {
      campoHabilitado = false;
      firestore
          .collection("solicitacaoTrocaOleo")
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
                                                  blocSolicitacaoTrocaOleo
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
                                                  blocSolicitacaoTrocaOleo
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
                                                              blocSolicitacaoTrocaOleo
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
                                                              blocSolicitacaoTrocaOleo
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
                                                    blocSolicitacaoTrocaOleo
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
                                                obrigaCampo: true,
                                                enabled: false,
                                                controller: tDataAbertura,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoTrocaOleo
                                                      .setDataAbertura(
                                                          tDataAbertura.text);
                                                },
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
                                                controller: tDataEfetivacao,
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
                            height: 20.0,
                          ),
                          Container(
                            child: AppText(
                              'Informações da Troca de Óleo',
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
                                                labelCampo: 'Oficina',
                                                largura: 500,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tOficina,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoTrocaOleo
                                                      .setOficina(
                                                          tOficina.text);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              constroiCampo(
                                                labelCampo: 'Fornecedor',
                                                largura: 500,
                                                altura: 30,
                                                obrigaCampo: false,
                                                controller: tFornecedor,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoTrocaOleo
                                                      .setFornecedor(
                                                          tFornecedor.text);
                                                },
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
                                                  blocSolicitacaoTrocaOleo
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

                                                  blocSolicitacaoTrocaOleo
                                                      .setCustoTotal(
                                                          double.parse(
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
                                                  blocSolicitacaoTrocaOleo
                                                      .setQuantidade(
                                                          double.tryParse(
                                                              tQuantidade
                                                                  .text));
                                                  tCustoTotal.text =
                                                      calculaValorTotalSolicitacao(
                                                    double.tryParse(
                                                        tPrecoLitro.text),
                                                    double.tryParse(
                                                        tQuantidade.text),
                                                  ).toString();
                                                  blocSolicitacaoTrocaOleo
                                                      .setCustoTotal(
                                                          double.parse(
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
                                              onChanged: (String valor) {
                                                blocSolicitacaoTrocaOleo
                                                    .setCustoVinculado(
                                                        tCustoVinculado.text);
                                              },
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
                                                        blocSolicitacaoTrocaOleo
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
                                                          blocSolicitacaoTrocaOleo
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
    bool enabled,
    bool obrigaCampo,
    Function onChanged,
    TextEditingController controller,
  }) {
    return Form(
      child: AppTextField(
        label: labelCampo,
        onChanged: onChanged,
        width: largura,
        heigth: altura,
        enabled: enabled,
        required: obrigaCampo,
        controller: controller,
      ),
    );
  }
}

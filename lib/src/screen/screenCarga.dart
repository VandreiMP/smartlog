import 'dart:html';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Entidades/Bloc/carregamentoMercadoria-bloc.dart';
import 'package:smartlogproject/src/constantes/fatoresCubagem.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/calculaTotalCarga.dart';
import 'package:smartlogproject/src/funcoes/criaLista.dart';
import 'package:smartlogproject/src/funcoes/criaListaValoresCaminhao.dart';
import 'package:smartlogproject/src/funcoes/criaListaValoresEmbalagem.dart';
import 'package:smartlogproject/src/funcoes/criaListaValoresMotorista.dart';
import 'package:smartlogproject/src/funcoes/requiredLabel.dart';
import '../Components/scroll/scroll.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenCarga extends StatefulWidget {
  @override
  _ScreenCarga createState() => _ScreenCarga();
}

class _ScreenCarga extends State<ScreenCarga> {
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
      child: BlocProvider<CarregamentoMercadoriaBloc>(
        bloc: CarregamentoMercadoriaBloc(context),
        child: Row(
          children: <Widget>[
            Scroll(
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CriaCardAuxiliar(
                    caminhoImagem: "Images/carga.png",
                    nomeFormulario: "Carregamento de Mercadoria",
                    origem: 'CARGA',
                    origemDado: 'CARGA',
                    chaveConsulta: ModalRoute.of(context).settings.arguments,
                  ),
                  // CriaCardAjudaCaminhao(),
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
  final String caminhoImagem;
  final String nomeFormulario;

  const CriaCardFormulario({this.caminhoImagem, this.nomeFormulario});

  @override
  _CriaCardFormularioState createState() => _CriaCardFormularioState();
}

class _CriaCardFormularioState extends State<CriaCardFormulario> {
  List<String> situacaoCarga = [
    'Montagem da Carga',
    'Em Trânsito',
    'Mercadoria Entregue',
  ];

  final tCarga = TextEditingController();
  final tSaidaCaminhao = MaskedTextController(mask: mascaraData);
  final tNumeroRomaneio = TextEditingController();
  final tSituacaoExpedicao = TextEditingController();
  final tMotorista = TextEditingController();
  final tNomeMotorista = TextEditingController();
  final tComprador = TextEditingController();
  final tTelefone = MaskedTextController(mask: mascaraTelefone);
  final tDataEntrega = MaskedTextController(mask: mascaraData);
  final tSituacaoEntrega = TextEditingController();
  final tProduto = TextEditingController();
  final tEmbalagem = TextEditingController();
  final tCodEmbalagem = TextEditingController();
  final tCodCaminhao = TextEditingController();
  final tDsCaminhao = TextEditingController();
  final tQuantidadeEmbalagem = MaskedTextController(mask: mascaraQuantidade);
  final tPesoBruto = MaskedTextController(mask: mascaraPeso);
  final tPesoLiquido = MaskedTextController(mask: mascaraPreco);
  final tCubagemCarga = MaskedTextController(mask: mascaraPeso);
  final tQuantidade = MaskedTextController(mask: mascaraQuantidade);
  final tPrecoLiquido = MaskedTextController(mask: mascaraPreco);
  final tTotalDesp = MaskedTextController(mask: mascaraPreco);
  final tTotalCarga = MaskedTextController(mask: mascaraPreco);

  /*
  Variáveis de Controle para exibição das listas.
  */
  String valorSituacaoCarga = 'Montagem da Carga';
  bool consultaSituacaoCarga = true;

  @override
  Widget build(BuildContext context) {
    CarregamentoMercadoriaBloc blocCarregamentoMercadoria =
        BlocProvider.of<CarregamentoMercadoriaBloc>(context);

    print(valorSituacaoCarga);

    blocCarregamentoMercadoria.setSituacaoExpedicao(valorSituacaoCarga);

    final Firestore firestore = Firestore.instance;
    String numeroCarga = ModalRoute.of(context).settings.arguments;

    void consultaEmbalagem() async {
      firestore
          .collection("embalagem")
          .document(tCodEmbalagem.text)
          .get()
          .then((value) async => tEmbalagem.text = value.data['descricao']);
    }

    void consultaCaminhao() async {
      firestore
          .collection("caminhao")
          .document(tCodCaminhao.text)
          .get()
          .then((value) async => tDsCaminhao.text = value.data['descricao']);
    }

    void consultaMotorista() async {
      firestore
          .collection("usuario")
          .document(tMotorista.text)
          .get()
          .then((value) async => tNomeMotorista.text = value.data['nome']);
    }

    void atualizaSituacaoCarga(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          valorSituacaoCarga = valor;
          print(valorSituacaoCarga);
          blocCarregamentoMercadoria.setSituacaoExpedicao(valorSituacaoCarga);
          consultaSituacaoCarga = false;
        });
      }
    }

    Future consultaDados(DocumentSnapshot campo) async {
      if (numeroCarga.isNotEmpty) {
        tCarga.text = numeroCarga;
      }
      tSaidaCaminhao.text = campo.data['saidaCaminhao'];
      tNumeroRomaneio.text = campo.data['numeroRomaneio'];
      tSituacaoExpedicao.text = campo.data['situacaoExpedicao'];
      tMotorista.text = campo.data['motorista'];
      tComprador.text = campo.data['comprador'];
      tTelefone.text = campo.data['telefone'];
      tDataEntrega.text = campo.data['dataEntrega'];
      tSituacaoEntrega.text = campo.data['situacaoEntrega'];
      tProduto.text = campo.data['produto'];
      tCodEmbalagem.text = campo.data['embalagem'];
      tCodCaminhao.text = campo.data['caminhao'];

      tQuantidadeEmbalagem.text = campo.data['quantidadeEmbalagem'].toString();
      tPesoBruto.text = campo.data['pesoBruto'].toString();

      tPesoLiquido.text = campo.data['pesoLiquido'].toString();
      tCubagemCarga.text = campo.data['cubagemCarga'].toString();
      tPrecoLiquido.text = campo.data['precoLiquido'].toString();
      tQuantidade.text = campo.data['quantidade'].toString();
      tTotalDesp.text = campo.data['totalDesp'].toString();
      tCubagemCarga.text = campo.data['cubagemCarga'].toString();
      tTotalCarga.text = campo.data['totalCarga'].toString();

      if (consultaSituacaoCarga == true) {
        tSituacaoExpedicao.text = campo.data['situacaoExpedicao'];
        atualizaSituacaoCarga(tSituacaoExpedicao.text);
      }

      blocCarregamentoMercadoria.setCarga(tCarga.text);
      blocCarregamentoMercadoria.setNumeroRomaneio(tNumeroRomaneio.text);

      blocCarregamentoMercadoria.setComprador(tComprador.text);
      blocCarregamentoMercadoria.setTelefone(tTelefone.text);
      blocCarregamentoMercadoria.setDataEntrega(tDataEntrega.text);
      blocCarregamentoMercadoria.setSituacaoEntrega(tSituacaoEntrega.text);
      blocCarregamentoMercadoria.setProduto(tProduto.text);

      consultaEmbalagem();
      consultaCaminhao();
      consultaMotorista();

      blocCarregamentoMercadoria.setEmbalagem(tCodEmbalagem.text);
      blocCarregamentoMercadoria.setCaminhao(tCodCaminhao.text);
      blocCarregamentoMercadoria.setMototista(tMotorista.text);

      blocCarregamentoMercadoria
          .setQuantidadeEmbalagem(double.tryParse(tQuantidadeEmbalagem.text));
      blocCarregamentoMercadoria.setPesoBruto(double.tryParse(tPesoBruto.text));

      blocCarregamentoMercadoria
          .setPesoLiquido(double.tryParse(tPesoLiquido.text));
      blocCarregamentoMercadoria
          .setCubagemCarga(double.tryParse(tCubagemCarga.text));
      blocCarregamentoMercadoria
          .setPrecoLiquido(double.tryParse(tPrecoLiquido.text));
      blocCarregamentoMercadoria
          .setQuantidade(double.tryParse(tQuantidade.text));
      blocCarregamentoMercadoria.setTotalDesp(double.tryParse(tTotalDesp.text));
      blocCarregamentoMercadoria
          .setCubagemCarga(double.tryParse(tCubagemCarga.text));
    }

    if (numeroCarga != null) {
      firestore
          .collection("carregamentoMercadoria")
          .document(numeroCarga)
          .get()
          .then((value) async => consultaDados(value));
    }

    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("carregamentoMercadoria").snapshots(),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Carga',
                                              largura: 85,
                                              altura: 30,
                                              controller: tCarga,
                                              onChanged: (String valor) {
                                                blocCarregamentoMercadoria
                                                    .setCarga(tCarga.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Data Saída',
                                                largura: 85,
                                                altura: 30,
                                                obrigaCampo: false,
                                                controller: tSaidaCaminhao,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setSaidaCaminhao(
                                                          tSaidaCaminhao.text);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
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
                                                      onTap: () {
                                                        blocCarregamentoMercadoria
                                                            .verificaCarga(
                                                                tCarga.text,
                                                                context,
                                                                () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                      '/FormularioRomaneio',
                                                                      arguments:
                                                                          numeroCarga,
                                                                    ));
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
                                                          Icons.explore,
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
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RequiredLabel(
                                                    'Situação Expedição',
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
                                                            items: situacaoCarga
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
                                                                valorSituacaoCarga),
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
                                                              blocCarregamentoMercadoria
                                                                  .verificaAlteracaoExpedicao(
                                                                      tCarga
                                                                          .text,
                                                                      context,
                                                                      'TRANSITO')
                                                                  .then((mensagemRetorno) => mensagemRetorno ==
                                                                          'OK'
                                                                      ? atualizaSituacaoCarga(
                                                                          'Em Trânsito')
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
                                                                    .arrow_forward,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .blue[900],
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
                                                              blocCarregamentoMercadoria
                                                                  .verificaAlteracaoExpedicao(
                                                                      tCarga
                                                                          .text,
                                                                      context,
                                                                      'ENTREGA')
                                                                  .then((mensagemRetorno) => mensagemRetorno ==
                                                                          'OK'
                                                                      ? atualizaSituacaoCarga(
                                                                          'Mercadoria Entregue')
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
                                            constroiCampo(
                                              labelCampo: 'Caminhão',
                                              largura: 450,
                                              altura: 30,
                                              enabled: false,
                                              controller: tDsCaminhao,
                                              obrigaCampo: true,
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
                                                        tCodCaminhao.text = '';
                                                        tDsCaminhao.text = '';
                                                        blocCarregamentoMercadoria
                                                            .setCaminhao(
                                                                tCodCaminhao
                                                                    .text);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.cancel,
                                                          size: 25.0,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                                        tCodCaminhao
                                                            .text = await Navigator
                                                                .of(context)
                                                            .push(
                                                                PageRouteBuilder(
                                                          opaque: false,
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              ListaValoresCaminhao(
                                                                  double.tryParse(
                                                                      tPesoBruto
                                                                          .text)),
                                                        ));

                                                        if (tCodCaminhao
                                                            .text.isNotEmpty) {
                                                          firestore
                                                              .collection(
                                                                  "caminhao")
                                                              .document(
                                                                  tCodCaminhao
                                                                      .text)
                                                              .get()
                                                              .then((value) async =>
                                                                  tDsCaminhao
                                                                      .text = value
                                                                          .data[
                                                                      'descricao']);
                                                          blocCarregamentoMercadoria
                                                              .setCaminhao(
                                                                  tCodCaminhao
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
                                                          Icons.local_shipping,
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
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Motorista',
                                              largura: 450,
                                              altura: 30,
                                              controller: tNomeMotorista,
                                              enabled: false,
                                              obrigaCampo: true,
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
                                                        tMotorista.text = '';
                                                        tNomeMotorista.text =
                                                            '';
                                                        blocCarregamentoMercadoria
                                                            .setMototista(
                                                                tMotorista
                                                                    .text);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.cancel,
                                                          size: 25.0,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                                        tMotorista
                                                            .text = await Navigator
                                                                .of(context)
                                                            .push(
                                                                PageRouteBuilder(
                                                          opaque: false,
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              ListaValoresMotorista(),
                                                        ));

                                                        if (tMotorista
                                                            .text.isNotEmpty) {
                                                          firestore
                                                              .collection(
                                                                  "usuario")
                                                              .document(
                                                                  tMotorista
                                                                      .text)
                                                              .get()
                                                              .then((value) async =>
                                                                  tNomeMotorista
                                                                      .text = value
                                                                          .data[
                                                                      'nome']);
                                                          blocCarregamentoMercadoria
                                                              .setMototista(
                                                                  tMotorista
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
                                                          Icons.person,
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: AppText(
                              'Mercadoria Carregada',
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
                                            constroiCampo(
                                              labelCampo: 'Comprador',
                                              largura: 300,
                                              altura: 30,
                                              controller: tComprador,
                                              onChanged: (String valor) {
                                                blocCarregamentoMercadoria
                                                    .setComprador(
                                                        tComprador.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: Container(
                                                child: constroiCampo(
                                                  labelCampo: 'Telefone',
                                                  largura: 110,
                                                  altura: 30,
                                                  obrigaCampo: false,
                                                  controller: tTelefone,
                                                  onChanged: (String valor) {
                                                    blocCarregamentoMercadoria
                                                        .setTelefone(
                                                            tTelefone.text);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Previsão Entrega',
                                                largura: 85,
                                                altura: 30,
                                                controller: tDataEntrega,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setDataEntrega(
                                                          tDataEntrega.text);
                                                },
                                                obrigaCampo: true,
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
                                            constroiCampo(
                                              labelCampo: 'Produto',
                                              largura: 450,
                                              altura: 30,
                                              controller: tProduto,
                                              onChanged: (String valor) {
                                                blocCarregamentoMercadoria
                                                    .setProduto(tProduto.text);
                                              },
                                              obrigaCampo: false,
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
                                              labelCampo: 'Embalagem',
                                              enabled: false,
                                              largura: 450,
                                              altura: 30,
                                              controller: tEmbalagem,
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
                                                        tCodEmbalagem.text = '';
                                                        tEmbalagem.text = '';
                                                        blocCarregamentoMercadoria
                                                            .setEmbalagem(
                                                                tCodEmbalagem
                                                                    .text);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.cancel,
                                                          size: 25.0,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                                        tCodEmbalagem
                                                            .text = await Navigator
                                                                .of(context)
                                                            .push(
                                                                PageRouteBuilder(
                                                          opaque: false,
                                                          pageBuilder: (_, __,
                                                                  ___) =>
                                                              ListaValoresEmbalagem(),
                                                        ));
                                                        if (tCodEmbalagem
                                                            .text.isNotEmpty) {
                                                          firestore
                                                              .collection(
                                                                  "embalagem")
                                                              .document(
                                                                  tCodEmbalagem
                                                                      .text)
                                                              .get()
                                                              .then((value) async =>
                                                                  tEmbalagem
                                                                      .text = value
                                                                          .data[
                                                                      'descricao']);
                                                          blocCarregamentoMercadoria
                                                              .setEmbalagem(
                                                                  tCodEmbalagem
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
                                                          Icons.shopping_basket,
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
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Peso Bruto',
                                              largura: 85,
                                              altura: 30,
                                              controller: tPesoBruto,
                                              onChanged: (String valor) {
                                                print(tCodCaminhao.text);
                                                blocCarregamentoMercadoria
                                                    .verificaCapacidadeCaminhao(
                                                        tCodCaminhao.text,
                                                        double.tryParse(
                                                            tPesoBruto.text),
                                                        context)
                                                    .then((mensagemRetorno) =>
                                                        mensagemRetorno == 'OK'
                                                            ? blocCarregamentoMercadoria
                                                                .setPesoBruto(
                                                                    double.tryParse(
                                                                        tPesoBruto
                                                                            .text))
                                                            : tPesoBruto.text =
                                                                '');
                                              },
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Peso Líq.',
                                                largura: 85,
                                                altura: 30,
                                                controller: tPesoLiquido,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setPesoLiquido(
                                                          double.tryParse(
                                                              tPesoLiquido
                                                                  .text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Qtd. Embalagem',
                                                largura: 85,
                                                altura: 30,
                                                controller:
                                                    tQuantidadeEmbalagem,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setQuantidadeEmbalagem(
                                                          double.tryParse(
                                                              tQuantidadeEmbalagem
                                                                  .text));
                                                  print(tQuantidadeEmbalagem
                                                      .text.isEmpty);
                                                  if (tQuantidadeEmbalagem
                                                          .text.isEmpty ==
                                                      true) {
                                                    tCubagemCarga.text = '';
                                                    blocCarregamentoMercadoria
                                                        .setCubagemCarga(
                                                            double.tryParse(
                                                                tCubagemCarga
                                                                    .text));
                                                  }
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Volume Real',
                                                largura: 85,
                                                altura: 30,
                                                enabled: false,
                                                controller: tCubagemCarga,
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  blocCarregamentoMercadoria
                                                      .verificaCubagem(
                                                          tCodEmbalagem.text,
                                                          double.tryParse(
                                                              tQuantidadeEmbalagem
                                                                  .text),
                                                          context);
                                                  await Firestore.instance
                                                      .collection("embalagem")
                                                      .document(
                                                          tCodEmbalagem.text)
                                                      .get()
                                                      .then(
                                                        (coluna) async => tCubagemCarga
                                                            .text = (coluna
                                                                        .data[
                                                                    'cubagem'] *
                                                                double.tryParse(
                                                                    tQuantidadeEmbalagem
                                                                        .text) *
                                                                fatorModalRodoviario)
                                                            .toString(),
                                                      );
                                                  blocCarregamentoMercadoria
                                                      .setCubagemCarga(
                                                          double.tryParse(
                                                              tCubagemCarga
                                                                  .text));
                                                  if (tCubagemCarga.text !=
                                                      null) {
                                                    alert(
                                                        context,
                                                        mensagemNotificacao,
                                                        'Caso as informações de dimensão da embalagem sejam alteradas, será necessário recalcular o volume real da carga!');
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[900],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(2.0),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.functions,
                                                    size: 25.0,
                                                    color: Colors.white,
                                                  ),
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
                                            constroiCampo(
                                              labelCampo: 'Quantidade',
                                              largura: 85,
                                              altura: 30,
                                              controller: tQuantidade,
                                              onChanged: (String valor) {
                                                tTotalCarga.text =
                                                    calculaValorTotalCarga(
                                                  double.tryParse(
                                                      tPrecoLiquido.text),
                                                  double.tryParse(
                                                      tQuantidade.text),
                                                  double.tryParse(
                                                      tTotalDesp.text),
                                                ).toString();
                                                blocCarregamentoMercadoria
                                                    .setQuantidade(
                                                        double.tryParse(
                                                            tQuantidade.text));
                                              },
                                              obrigaCampo: false,
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
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Preço Líq.',
                                                largura: 85,
                                                altura: 30,
                                                controller: tPrecoLiquido,
                                                onChanged: (String valor) {
                                                  tTotalCarga.text =
                                                      calculaValorTotalCarga(
                                                    double.tryParse(
                                                        tPrecoLiquido.text),
                                                    double.tryParse(
                                                        tQuantidade.text),
                                                    double.tryParse(
                                                        tTotalDesp.text),
                                                  ).toString();
                                                  blocCarregamentoMercadoria
                                                      .setPrecoLiquido(
                                                          double.tryParse(
                                                              tPrecoLiquido
                                                                  .text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '+',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Total Desp.',
                                                largura: 85,
                                                altura: 30,
                                                controller: tTotalDesp,
                                                onChanged: (String valor) {
                                                  tTotalCarga.text =
                                                      calculaValorTotalCarga(
                                                    double.tryParse(
                                                        tPrecoLiquido.text),
                                                    double.tryParse(
                                                        tQuantidade.text),
                                                    double.tryParse(
                                                        tTotalDesp.text),
                                                  ).toString();
                                                  blocCarregamentoMercadoria
                                                      .setTotalDesp(
                                                          double.tryParse(
                                                              tTotalDesp.text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
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
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                '/FormularioDespesasContrato');
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
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Total Carga',
                                                largura: 85,
                                                altura: 30,
                                                controller: tTotalCarga,
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
                            height: 10.0,
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
    double largura,
    bool enabled,
    double altura,
    bool obrigaCampo,
    Function onChanged,
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

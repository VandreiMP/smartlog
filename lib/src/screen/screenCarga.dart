import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Entidades/Bloc/carregamentoMercadoria-bloc.dart';
import 'package:smartlogproject/src/funcoes/criaLista.dart';
import 'package:smartlogproject/src/funcoes/criaListaValores.dart';
import 'package:smartlogproject/src/funcoes/requiredLabel.dart';
import '../Components/scroll/scroll.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';

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

class CriaCardFormulario extends StatelessWidget {
  final String caminhoImagem;
  final String nomeFormulario;

  const CriaCardFormulario({this.caminhoImagem, this.nomeFormulario});

  @override
  Widget build(BuildContext context) {
    final tCarga = TextEditingController();
    final tSaidaCaminhao = TextEditingController();
    final tNumeroRomaneio = TextEditingController();
    final tSituacaoExpedicao = TextEditingController();
    final tCaminhao = TextEditingController();
    final tMotorista = TextEditingController();
    final tComprador = TextEditingController();
    final tTelefone = TextEditingController();
    final tDataEntrega = TextEditingController();
    final tSituacaoEntrega = TextEditingController();
    final tProduto = TextEditingController();
    final tEmbalagem = TextEditingController();
    final tPesoBruto = TextEditingController();
    final tPesoLiquido = TextEditingController();
    final tCubagemCarga = TextEditingController();
    final tQuantidade = TextEditingController();
    final tPrecoLiquido = TextEditingController();
    final tTotalCarga = TextEditingController();

    List<String> situacaoCarga = [
      'Montagem da Carga',
      'Mercadoria Carregada',
      'Bloqueada para Faturamento',
      'Liberada para Saída',
      'Entrega Efetuada',
    ];

    List<String> situacaoEntrega = [
      'Ativa',
      'Encerrada',
      'Cancelada',
    ];

    CarregamentoMercadoriaBloc blocCarregamentoMercadoria =
        BlocProvider.of<CarregamentoMercadoriaBloc>(context);

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
                                                labelCampo: 'Saída Caminhão',
                                                largura: 85,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tSaidaCaminhao,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setSaidaCaminhao(
                                                          tSaidaCaminhao.text);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Romaneio',
                                                largura: 85,
                                                altura: 30,
                                                controller: tNumeroRomaneio,
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
                                                        if (tCarga
                                                            .text.isNotEmpty) {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  '/FormularioRomaneio',
                                                                  arguments:
                                                                      tCarga
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
                                                  left: 25.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RequiredLabel(
                                                    'Situação Expedição',
                                                    true,
                                                  ),
                                                  Container(
                                                    child: DropDown(
                                                        valores: situacaoCarga),
                                                  ),
                                                ],
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
                                                        //alterar a situação da expedição para "Liberada para Saída"
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
                                                          Icons.lock_open,
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
                                              labelCampo: 'Caminhão',
                                              largura: 150,
                                              altura: 30,
                                              controller: tCaminhao,
                                              onChanged: (String valor) {
                                                blocCarregamentoMercadoria
                                                    .setCaminhao(
                                                        tCaminhao.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                //descrição do caminhão
                                                largura: 300,
                                                altura: 30,
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
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Motorista',
                                              largura: 150,
                                              altura: 30,
                                              controller: tMotorista,
                                              onChanged: (String valor) {
                                                blocCarregamentoMercadoria
                                                    .setMototista(
                                                        tMotorista.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                //nome do motorista
                                                largura: 300,
                                                altura: 30,
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
                                              obrigaCampo: false,
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RequiredLabel(
                                                    'Situação',
                                                    true,
                                                  ),
                                                  Container(
                                                    child: DropDown(
                                                        valores:
                                                            situacaoEntrega),
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
                                              labelCampo: 'Produto',
                                              largura: 300,
                                              altura: 30,
                                              controller: tProduto,
                                              onChanged: (String valor) {
                                                blocCarregamentoMercadoria
                                                    .setProduto(tProduto.text);
                                              },
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Embalagem',
                                                largura: 200,
                                                altura: 30,
                                                controller: tEmbalagem,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setEmbalagem(
                                                          tEmbalagem.text);
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
                                                                '/ListaValoresEmbalagem');
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
                                                          Icons.add,
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
                                                blocCarregamentoMercadoria
                                                    .setPesoBruto(
                                                        tPesoBruto.text);
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
                                                          tPesoLiquido.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Cubagem/Vol.',
                                                largura: 85,
                                                altura: 30,
                                                controller: tCubagemCarga,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setCubagemCarga(
                                                          tCubagemCarga.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Quantidade',
                                                largura: 85,
                                                altura: 30,
                                                controller: tQuantidade,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setQuantidade(
                                                          tQuantidade.text);
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
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Preço Líq.',
                                                largura: 85,
                                                altura: 30,
                                                controller: tPrecoLiquido,
                                                onChanged: (String valor) {
                                                  blocCarregamentoMercadoria
                                                      .setPrecoLiquido(
                                                          tPrecoLiquido.text);
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
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Total Carga',
                                                largura: 85,
                                                altura: 30,
                                                controller: tTotalCarga,
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
                                          children: <Widget>[],
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
        heigth: altura,
        required: obrigaCampo,
        controller: controller,
      ),
    );
  }
}

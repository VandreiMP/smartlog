import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Entidades/Bloc/fichaCaminhao-bloc.dart';
import 'package:smartlogproject/src/util/M%C3%A9todos%20de%20C%C3%A1lculo/calculaCubagem.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'package:smartlogproject/src/util/Componentes/appTextField.dart';

class ScreenCaminhaoDetalhes extends StatefulWidget {
  @override
  _ScreenCaminhaoDetalhes createState() => _ScreenCaminhaoDetalhes();
}

class _ScreenCaminhaoDetalhes extends State<ScreenCaminhaoDetalhes> {
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
      child: BlocProvider<FichaCaminhaoBloc>(
        bloc: FichaCaminhaoBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/veiculo.png",
                  nomeFormulario: "FICHA TÉCNICA DO CAMINHÃO",
                  origem: 'DETALHES_CAMINHAO',
                  origemDado: 'DETALHES_CAMINHAO',
                  chaveConsulta: ModalRoute.of(context).settings.arguments,
                ),
                // CriaCardAjudaCaminhaoDetalhes(),
              ],
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
    /*
    Variáveis usadas para capturar o valor dos colunas do formulário
    e salvar no banco
    */
    final tidCaminhao = TextEditingController();
    final tCor = TextEditingController();
    final tQuilometragemLitro = TextEditingController();
    final tCapacidadeCarga = TextEditingController();
    final tPesoVazio = TextEditingController();
    final tNumeroEixos = TextEditingController();
    final tComprimentoCarga = TextEditingController();
    final tAlturaCarga = TextEditingController();
    final tLarguraCarga = TextEditingController();
    final tCubagem = TextEditingController();

    String codigoCaminhao = ModalRoute.of(context).settings.arguments;
    FichaCaminhaoBloc blocFichaCaminhao =
        BlocProvider.of<FichaCaminhaoBloc>(context);
    final Firestore firestore = Firestore.instance;

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */
    Future consultaDados(DocumentSnapshot coluna) async {
      if (coluna.exists == true) {
        tCor.text = coluna.data['cor'];
        if (coluna.data['quilometragemLitro'] != null) {
          tQuilometragemLitro.text =
              coluna.data['quilometragemLitro'].toString();
        } else {
          tQuilometragemLitro.text = '0.00';
        }
        if (coluna.data['capacidadeCarga'] != null) {
          tCapacidadeCarga.text = coluna.data['capacidadeCarga'].toString();
        } else {
          tCapacidadeCarga.text = '0.00';
        }
        if (coluna.data['pesoVazio'] != null) {
          tPesoVazio.text = coluna.data['pesoVazio'].toString();
        } else {
          tPesoVazio.text = '0.00';
        }
        if (coluna.data['numeroEixos'] != null) {
          tNumeroEixos.text = coluna.data['numeroEixos'].toString();
        } else {
          tNumeroEixos.text = '0';
        }
        if (coluna.data['comprimentoCarga'] != null) {
          tComprimentoCarga.text = coluna.data['comprimentoCarga'].toString();
        } else {
          tComprimentoCarga.text = '0.00';
        }
        if (coluna.data['alturaCarga'] != null) {
          tAlturaCarga.text = coluna.data['alturaCarga'].toString();
        } else {
          tAlturaCarga.text = '0.00';
        }
        if (coluna.data['larguraCarga'] != null) {
          tLarguraCarga.text = coluna.data['larguraCarga'].toString();
        } else {
          tLarguraCarga.text = '0.00';
        }
        if (coluna.data['cubagemCarga'] != null) {
          tCubagem.text = coluna.data['cubagemCarga'].toString();
        } else {
          tCubagem.text = '0.00';
        }
        blocFichaCaminhao.setCor(tCor.text);
        blocFichaCaminhao
            .setQuilometragemLitro(double.parse(tQuilometragemLitro.text));
        blocFichaCaminhao
            .setCapacidadeCarga(double.parse(tCapacidadeCarga.text));
        blocFichaCaminhao.setPesoVazio(double.parse(tPesoVazio.text));
        blocFichaCaminhao.setNumeroEixos(int.parse(tNumeroEixos.text));
        blocFichaCaminhao
            .setComprimentoCarga(double.parse(tComprimentoCarga.text));
        blocFichaCaminhao.setAlturaCarga(double.parse(tAlturaCarga.text));
        blocFichaCaminhao.setLarguraCarga(double.parse(tLarguraCarga.text));
        blocFichaCaminhao.setCubagemCarga(double.parse(tCubagem.text));
      }
    }

    if (codigoCaminhao != null) {
      firestore.collection("fichaCaminhao").document(codigoCaminhao).get().then(
            (coluna) async => consultaDados(coluna),
          );
    }

    if (codigoCaminhao.isNotEmpty) {
      tidCaminhao.text = codigoCaminhao;
      blocFichaCaminhao.setIdCaminhao(tidCaminhao.text);
    }

    return Column(
      children: [
        StreamBuilder<FichaCaminhaoBloc>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 2.0),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
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
                              'Ficha Técnica do Veículo',
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
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            constroiCampo(
                                                labelCampo: 'Cor',
                                                largura: 100,
                                                controller: tCor,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setCor(tCor.text);
                                                },
                                                altura: 30,
                                                obrigaCampo: false),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50.0),
                                              child: constroiCampo(
                                                labelCampo: 'Km/L',
                                                largura: 80,
                                                controller: tQuilometragemLitro,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setQuilometragemLitro(
                                                          double.parse(
                                                              tQuilometragemLitro
                                                                  .text));
                                                },
                                                altura: 30,
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50.0),
                                              child: constroiCampo(
                                                labelCampo: 'Capac.(Kg)',
                                                largura: 80,
                                                altura: 30,
                                                controller: tCapacidadeCarga,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setCapacidadeCarga(
                                                          double.parse(
                                                              tCapacidadeCarga
                                                                  .text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50.0),
                                              child: constroiCampo(
                                                labelCampo: 'Peso vazio',
                                                largura: 80,
                                                altura: 30,
                                                obrigaCampo: false,
                                                controller: tPesoVazio,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setPesoVazio(
                                                          double.parse(
                                                              tPesoVazio.text));
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50.0),
                                              child: constroiCampo(
                                                labelCampo: 'Eixos',
                                                largura: 60,
                                                controller: tNumeroEixos,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setNumeroEixos(int.parse(
                                                          tNumeroEixos.text));
                                                },
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
                                                labelCampo: 'Comp.(Mt)',
                                                largura: 80,
                                                controller: tComprimentoCarga,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setComprimentoCarga(
                                                          double.parse(
                                                              tComprimentoCarga
                                                                  .text));
                                                  tCubagem
                                                      .text = calculaCubagem(
                                                          double.parse(
                                                              tLarguraCarga
                                                                  .text),
                                                          double.parse(
                                                              tComprimentoCarga
                                                                  .text),
                                                          double.parse(
                                                              tAlturaCarga
                                                                  .text))
                                                      .toString();
                                                  blocFichaCaminhao
                                                      .setCubagemCarga(
                                                          double.parse(
                                                              tCubagem.text));
                                                },
                                                altura: 30,
                                                obrigaCampo: false),
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
                                                  left: 4.0),
                                              child: constroiCampo(
                                                labelCampo: 'Alt.(Mt)',
                                                controller: tAlturaCarga,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setAlturaCarga(
                                                          double.parse(
                                                              tAlturaCarga
                                                                  .text));
                                                  tCubagem
                                                      .text = calculaCubagem(
                                                          double.parse(
                                                              tLarguraCarga
                                                                  .text),
                                                          double.parse(
                                                              tComprimentoCarga
                                                                  .text),
                                                          double.parse(
                                                              tAlturaCarga
                                                                  .text))
                                                      .toString();
                                                  blocFichaCaminhao
                                                      .setCubagemCarga(
                                                          double.parse(
                                                              tCubagem.text));
                                                },
                                                largura: 80,
                                                altura: 30,
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
                                                  left: 4.0),
                                              child: constroiCampo(
                                                labelCampo: 'Larg.(Mt)',
                                                largura: 80,
                                                altura: 30,
                                                controller: tLarguraCarga,
                                                onChanged: (String valor) {
                                                  blocFichaCaminhao
                                                      .setLarguraCarga(
                                                          double.parse(
                                                              tLarguraCarga
                                                                  .text));
                                                  tCubagem
                                                      .text = calculaCubagem(
                                                          double.parse(
                                                              tLarguraCarga
                                                                  .text),
                                                          double.parse(
                                                              tComprimentoCarga
                                                                  .text),
                                                          double.parse(
                                                              tAlturaCarga
                                                                  .text))
                                                      .toString();
                                                  blocFichaCaminhao
                                                      .setCubagemCarga(
                                                          double.parse(
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: constroiCampo(
                                                  labelCampo: 'Cubagem',
                                                  largura: 80,
                                                  controller: tCubagem,
                                                  altura: 30,
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
                            height: 10.0,
                          ),
                        ]),
                  ),
                ),
              );
            }),
      ],
    );
  }
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
      width: largura,
      heigth: altura,
      onChanged: onChanged,
      required: obrigaCampo,
      controller: controller,
    ),
  );
}

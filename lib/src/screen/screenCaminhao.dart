import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/caminhao-bloc.dart';

import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

class ScreenCaminhao extends StatefulWidget {
  @override
  _ScreenCaminhao createState() => _ScreenCaminhao();
}

class _ScreenCaminhao extends State<ScreenCaminhao> {
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
      child: BlocProvider<CaminhaoBloc>(
        bloc: CaminhaoBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/veiculo.png",
                  nomeFormulario: "Cadastro de Frota",
                  origem: 'CAMINHAO',
                  origemDado: 'CAMINHAO',
                  chaveConsulta: ModalRoute.of(context).settings.arguments,
                ),
                // CriaCardAjudaCaminhao(),
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
  final String caminhoImagem;
  final String nomeFormulario;

  const CriaCardFormulario({this.caminhoImagem, this.nomeFormulario});

  @override
  _CriaCardFormularioState createState() => _CriaCardFormularioState();
}

class _CriaCardFormularioState extends State<CriaCardFormulario> {
  List<String> tipoCarroceria = [
    'Aberta',
    'Baú',
    'Granelera',
    'Porta Container',
    'Sider',
    'Tanque',
    'Outros'
  ];

  List<String> tipoVeiculo = [
    'Caminhão Leve (3,5T A 7,99T)',
    'Caminhão Simples (8T A 29T)',
    'Caminhão Trator',
    'Caminhão Trator Especial',
    'Caminhonete / Furgão (1,5T A 3,49T)',
    'Reboque',
    'Semi-Reboque',
    'Semi-Reboque c/ 5 Roda / Bitrem',
    'Semi-Reboque Especial',
    'Utilitário Leve (0,5T A 1,49T)',
    'Veículo Operacional de Apoio'
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

  final tId = TextEditingController();
  final tPlaca = TextEditingController();
  final tAnoFabricacao = TextEditingController();
  final tUf = TextEditingController();
  final tDescricao = TextEditingController();
  final tModeloCaminhao = TextEditingController();
  final tFabricante = TextEditingController();
  final tTipoCarroceria = TextEditingController();
  final tCategoriaCaminhao = TextEditingController();
  final tChassiCaminhao = TextEditingController();
  final tNumeroRenavam = TextEditingController();
  final tNumeroRntrc = TextEditingController();
  final tTipoCombustivel = TextEditingController();

  /*
  Variáveis de Controle para exibição das listas.
  */
  String valorTipoCarroceria;
  bool consultaTipoCarroceria = true;
  String valorTipoCaminhao;
  bool consultaTipoCaminhao = true;
  String valorTipoCombustivel;
  bool consultaTipoCombustivel = true;

  @override
  Widget build(BuildContext context) {
    String codigoCaminhao = ModalRoute.of(context).settings.arguments;
    CaminhaoBloc blocCaminhao = BlocProvider.of<CaminhaoBloc>(context);
    final Firestore firestore = Firestore.instance;
    bool campoHabilitado = true;

    void atualizaTipoCarroceria(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          valorTipoCarroceria = valor;
          blocCaminhao.setTipoCarroceria(valorTipoCarroceria);
          consultaTipoCarroceria = false;
        });
      }
    }

    void atualizaTipoCaminhao(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          valorTipoCaminhao = valor;
          blocCaminhao.setCategoriaCaminhao(valorTipoCaminhao);
          consultaTipoCaminhao = false;
        });
      }
    }

    void atualizaTipoCombustivel(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          valorTipoCombustivel = valor;
          blocCaminhao.setTipoCombustivel(valorTipoCombustivel);
          consultaTipoCombustivel = false;
        });
      }
    }

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */

    Future consultaDados(DocumentSnapshot coluna) async {
      if (codigoCaminhao.isNotEmpty) {
        tId.text = codigoCaminhao;
      }
      tPlaca.text = coluna.data['placa'];
      tAnoFabricacao.text = coluna.data['anoFabricacao'].toString();
      tUf.text = coluna.data['uf'];
      tDescricao.text = coluna.data['descricao'];
      tModeloCaminhao.text = coluna.data['modeloCaminhao'];
      tFabricante.text = coluna.data['fabricante'];
      tChassiCaminhao.text = coluna.data['chassiCaminhao'];
      tNumeroRenavam.text = coluna.data['numeroRenavam'].toString();
      tNumeroRntrc.text = coluna.data['numeroRntrc'].toString();

      if (consultaTipoCarroceria == true) {
        tTipoCarroceria.text = coluna.data['tipoCarroceria'];
        atualizaTipoCarroceria(tTipoCarroceria.text);
      }

      if (consultaTipoCaminhao == true) {
        tCategoriaCaminhao.text = coluna.data['categoriaCaminhao'];
        atualizaTipoCaminhao(tCategoriaCaminhao.text);
      }

      if (consultaTipoCombustivel == true) {
        tTipoCombustivel.text = coluna.data['tipoCombustivel'];
        atualizaTipoCombustivel(tTipoCombustivel.text);
      }

      blocCaminhao.setIdentificacao(tId.text);
      blocCaminhao.setDescricao(tDescricao.text);
      blocCaminhao.setPlaca(tPlaca.text);
      blocCaminhao.setAnoFabricacao(int.parse(tAnoFabricacao.text));
      blocCaminhao.setUf(tUf.text);
      blocCaminhao.setModeloCaminhao(tModeloCaminhao.text);
      blocCaminhao.setFabricante(tFabricante.text);
      blocCaminhao.setChassiCaminhao(tChassiCaminhao.text);
      blocCaminhao.setNumeroRenavam(int.parse(tNumeroRenavam.text));
      blocCaminhao.setNumeroRntrc(int.parse(tNumeroRntrc.text));
    }

    if (codigoCaminhao != null) {
      campoHabilitado = false;
      firestore
          .collection("caminhao")
          .document(codigoCaminhao)
          .get()
          .then((coluna) async => consultaDados(coluna));
    }

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
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      constroiCampo(
                                        labelCampo: 'Identificação',
                                        largura: 150,
                                        altura: 30,
                                        contextoAplicacao: context,
                                        obrigaCampo: true,
                                        enabled: campoHabilitado,
                                        controller: tId,
                                        onChanged: (String valor) {
                                          blocCaminhao
                                              .setIdentificacao(tId.text);
                                        },
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
                                        labelCampo: 'Placa',
                                        controller: tPlaca,
                                        largura: 100,
                                        altura: 30,
                                        onChanged: (String valor) {
                                          blocCaminhao.setPlaca(tPlaca.text);
                                        },
                                        obrigaCampo: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'Ano',
                                          largura: 40,
                                          altura: 30,
                                          controller: tAnoFabricacao,
                                          obrigaCampo: true,
                                          onChanged: (String valor) {
                                            blocCaminhao.setAnoFabricacao(
                                                int.parse(tAnoFabricacao.text));
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: constroiCampo(
                                          labelCampo: 'UF',
                                          largura: 50,
                                          altura: 30,
                                          controller: tUf,
                                          onChanged: (String valor) {
                                            blocCaminhao.setUf(tUf.text);
                                          },
                                          obrigaCampo: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 100.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                                    'Categoria',
                                                    true,
                                                  ),
                                                  Container(
                                                    height: 50.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        DropdownButton<String>(
                                                          items:
                                                              tipoVeiculo.map((
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
                                                              atualizaTipoCaminhao(
                                                                  novoValorSelecionado),
                                                          value:
                                                              valorTipoCaminhao,
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
                                    ],
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
                                        controller: tDescricao,
                                        onChanged: (String valor) {
                                          blocCaminhao
                                              .setDescricao(tDescricao.text);
                                        },
                                        obrigaCampo: true,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    blocCaminhao
                                                        .verificaCaminhao(
                                                            tId.text, context);
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
                                                      Icons.local_shipping,
                                                      size: 25.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: GestureDetector(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[900],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2.0),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 25.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: GestureDetector(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[900],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2.0),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      Icons.attach_money,
                                                      size: 25.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      constroiCampo(
                                        labelCampo: 'Modelo',
                                        largura: 150,
                                        altura: 30,
                                        controller: tModeloCaminhao,
                                        onChanged: (String valor) {
                                          blocCaminhao.setModeloCaminhao(
                                              tModeloCaminhao.text);
                                        },
                                        obrigaCampo: false,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'Fabricante',
                                          largura: 150,
                                          altura: 30,
                                          controller: tFabricante,
                                          onChanged: (String valor) {
                                            blocCaminhao.setFabricante(
                                                tFabricante.text);
                                          },
                                          obrigaCampo: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                children: [
                                                  RequiredLabel(
                                                    'Carroceria',
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
                                                                  tipoCarroceria
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
                                                                  atualizaTipoCarroceria(
                                                                      novoValorSelecionado),
                                                              value:
                                                                  valorTipoCarroceria,
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
                                      )
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
                        'Informações Específicas',
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
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      constroiCampo(
                                          labelCampo: 'Chassi',
                                          largura: 200,
                                          controller: tChassiCaminhao,
                                          onChanged: (String valor) {
                                            blocCaminhao.setChassiCaminhao(
                                                tChassiCaminhao.text);
                                          },
                                          altura: 30,
                                          obrigaCampo: true),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 70.0),
                                        child: constroiCampo(
                                          labelCampo: 'Renavam',
                                          largura: 110,
                                          altura: 30,
                                          obrigaCampo: true,
                                          controller: tNumeroRenavam,
                                          onChanged: (String valor) {
                                            blocCaminhao.setNumeroRenavam(
                                              int.parse(tNumeroRenavam.text),
                                            );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 70.0),
                                        child: constroiCampo(
                                          labelCampo: 'RNTRC',
                                          largura: 100,
                                          altura: 30,
                                          controller: tNumeroRntrc,
                                          onChanged: (String valor) {
                                            blocCaminhao.setNumeroRntrc(
                                              int.parse(tNumeroRntrc.text),
                                            );
                                          },
                                          obrigaCampo: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 70.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                                        DropdownButton<String>(
                                                          items: tipoCombustivel
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
                                      )
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
              controller: controller,
              onChanged: onChanged,
              enabled: enabled,
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

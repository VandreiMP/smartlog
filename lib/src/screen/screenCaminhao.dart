import 'package:bloc_pattern/bloc_pattern.dart';
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
                  origem: 'ADICIONAIS',
                  origemDado: 'CAMINHAO',
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

class CriaCardFormulario extends StatelessWidget {
  final String caminhoImagem;
  final String nomeFormulario;

  const CriaCardFormulario({this.caminhoImagem, this.nomeFormulario});

  @override
  Widget build(BuildContext context) {
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
    final tChassiCaminhao = TextEditingController();
    final tNumeroRenavam = TextEditingController();
    final tNumeroRntrc = TextEditingController();
    final tTipoCombustivel = TextEditingController();

    CaminhaoBloc blocCaminhao = BlocProvider.of<CaminhaoBloc>(context);
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
                                                tAnoFabricacao.text);
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
                                            RequiredLabel(
                                              'Categoria do Veículo',
                                              true,
                                            ),
                                            Container(
                                              child: DropDown(
                                                  valores: tipoVeiculo),
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
                                                    Navigator.of(context).pushNamed(
                                                        '/FormularioCaminhaoDetalhes');
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
                                            RequiredLabel(
                                              'Carroceria',
                                              true,
                                            ),
                                            Container(
                                              child: DropDown(
                                                  valores: tipoCarroceria),
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
                                          largura: 100,
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
                                                tNumeroRenavam.text);
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
                                                tNumeroRntrc.text);
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
                                            RequiredLabel(
                                              'Combust.',
                                              true,
                                            ),
                                            Container(
                                              child: DropDown(
                                                  valores: tipoCombustivel),
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

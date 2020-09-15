import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Entidades/Bloc/romaneio-bloc.dart';
import 'package:smartlogproject/src/funcoes/criaLista.dart';
import 'package:smartlogproject/src/funcoes/requiredLabel.dart';
import '../Components/scroll/scroll.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenRomaneio extends StatefulWidget {
  @override
  _ScreenRomaneio createState() => _ScreenRomaneio();
}

class _ScreenRomaneio extends State<ScreenRomaneio> {
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
      child: BlocProvider<RomaneioBloc>(
        bloc: RomaneioBloc(context),
        child: Row(
          children: <Widget>[
            Scroll(
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CriaCardAuxiliar(
                    caminhoImagem: "Images/romaneio.png",
                    nomeFormulario: "Geração do Romaneio da Carga",
                    origem: 'ROMANEIO',
                    origemDado: 'ROMANEIO',
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
    final Object numeroCarga = ModalRoute.of(context).settings.arguments;

    List<String> modalidadeFrete = [
      'Contratação do Frete por Conta do Remetente (CIF)',
      'Contratação do Frete por Conta do Destinatário (FOB)',
      'Contratação do Frete por Conta de Terceiros',
      'Transporte Próprio por Conta do Remetente',
      'Transporte Próprio por Conta do Destinatário',
      'Sem Ocorrência de Transporte',
    ];

    final tCarga = TextEditingController();
    final tObservacao = TextEditingController();
    final tModalidadeFrete = TextEditingController();
    final tDataSaida = TextEditingController();
    final tDataRetorno = TextEditingController();
    final tDiasRodados = TextEditingController();
    final tQuilometrosRodados = TextEditingController();
    final tCidadeSaida = TextEditingController();
    final tUfSaida = TextEditingController();
    final tCidadeDestino = TextEditingController();
    final tUfDestino = TextEditingController();

    RomaneioBloc blocRomaneio = BlocProvider.of<RomaneioBloc>(context);
    final Object arguments = ModalRoute.of(context).settings.arguments;

    return StreamBuilder<RomaneioBloc>(
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
                                              labelCampo: 'Número Carga',
                                              largura: 85,
                                              altura: 30,
                                              controller: tCarga,
                                              onChanged: (String valor) {
                                                blocRomaneio
                                                    .setCarga(tCarga.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo:
                                                    'Observação do Romaneio',
                                                largura: 500,
                                                altura: 30,
                                                controller: tObservacao,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setObservacao(
                                                      tObservacao.text);
                                                },
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
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RequiredLabel(
                                                  'Modalidade Frete/Entrega',
                                                  true,
                                                ),
                                                Container(
                                                  child: DropDown(
                                                      valores: modalidadeFrete),
                                                ),
                                              ],
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
                              'Informações da Viagem',
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
                                              labelCampo: 'Data Saída',
                                              largura: 85,
                                              controller: tDataSaida,
                                              onChanged: (String valor) {
                                                blocRomaneio.setDataSaidaViagem(
                                                    tDataSaida.text);
                                              },
                                              altura: 30,
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '-',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Data Retorno',
                                                largura: 85,
                                                altura: 30,
                                                obrigaCampo: false,
                                                controller: tDataRetorno,
                                                onChanged: (String valor) {
                                                  blocRomaneio
                                                      .setDataRetornoViagem(
                                                          tDataRetorno.text);
                                                },
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
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Dias Rodados',
                                                largura: 85,
                                                altura: 30,
                                                controller: tDiasRodados,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setDiasRodados(
                                                      tDiasRodados.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'KMs Rodados',
                                                largura: 85,
                                                altura: 30,
                                                controller: tQuilometrosRodados,
                                                onChanged: (String valor) {
                                                  blocRomaneio
                                                      .setQuilometragemRodada(
                                                          tQuilometrosRodados
                                                              .text);
                                                },
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
                                              labelCampo: 'Cidade Saída',
                                              largura: 250,
                                              altura: 30,
                                              controller: tCidadeSaida,
                                              onChanged: (String valor) {
                                                blocRomaneio.setCidadeSaida(
                                                    tCidadeSaida.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'UF Saída',
                                                largura: 30,
                                                altura: 30,
                                                controller: tUfSaida,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setUfSaida(
                                                      tUfSaida.text);
                                                },
                                                obrigaCampo: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Cidade Destino',
                                                largura: 250,
                                                altura: 30,
                                                controller: tCidadeDestino,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setCidadeDestino(
                                                      tCidadeSaida.text);
                                                },
                                                obrigaCampo: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'UF Dest.',
                                                largura: 30,
                                                altura: 30,
                                                controller: tUfDestino,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setUfDestino(
                                                      tUfDestino.text);
                                                },
                                                obrigaCampo: true,
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
    double altura,
    Function onChanged,
    bool obrigaCampo,
    TextEditingController controller,
  }) {
    return Form(
      child: AppTextField(
        label: labelCampo,
        width: largura,
        onChanged: onChanged,
        heigth: altura,
        required: obrigaCampo,
        controller: controller,
      ),
    );
  }
}

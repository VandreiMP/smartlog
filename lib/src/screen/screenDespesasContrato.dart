import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenDespesasContrato extends StatefulWidget {
  @override
  _ScreenDespesasContrato createState() => _ScreenDespesasContrato();
}

class _ScreenDespesasContrato extends State<ScreenDespesasContrato> {
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
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CriaCardAuxiliar(
                caminhoImagem: "Images/contrato_venda.png",
                nomeFormulario: "Contrato de Venda",
                origem: 'DESPESAS_CONTRATO',
              ),
              // CriaCardAjudaCaminhaoDetalhes(),
            ],
          ),
          CriaCardFormulario()
        ],
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
    return Column(
      children: [
        Container(
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
                      'Despesas Adicionais do Contrato',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    constroiCampo(
                                        labelCampo: 'Matéria Prima',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 50.0),
                                      child: constroiCampo(
                                        labelCampo: 'Embalagem',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 50.0),
                                      child: constroiCampo(
                                        labelCampo: 'Logística',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    constroiCampo(
                                        labelCampo: 'Tributos',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 69.0),
                                      child: constroiCampo(
                                        labelCampo: 'Incidentes Prod.',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: constroiCampo(
                                        labelCampo: 'Multas',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    constroiCampo(
                                        labelCampo: 'Atrasos Ent.',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 58.0),
                                      child: constroiCampo(
                                        labelCampo: 'Retrabalho',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 58.0),
                                      child: constroiCampo(
                                        labelCampo: 'Outras Desp.',
                                        largura: 85,
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      constroiCampo(
                          labelCampo: 'Total Desp.',
                          largura: 85,
                          altura: 30,
                          obrigaCampo: false),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget constroiCampo({
  String labelCampo,
  double largura,
  double altura,
  bool obrigaCampo,
  TextEditingController mascara,
}) {
  return Form(
    child: AppTextField(
      label: labelCampo,
      width: largura,
      heigth: altura,
      required: obrigaCampo,
      controller: mascara,
    ),
  );
}

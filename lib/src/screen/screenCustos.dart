import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../funcoes/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
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
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CriaCardAuxiliar(
                caminhoImagem: "Images/money.png",
                nomeFormulario: "Cadastro de Custos",
                origem: 'CUSTOS',
              ),
              // CriaCardAjuda(),
            ],
          ),
          criaCardFormulario()
        ],
      ),
    );
  }
}

Widget criaCardFormulario({String caminhoImagem, String nomeFormulario}) {
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
  ];

  List<String> consideraAgr = [
    'Considera',
    'Desconsidera',
  ];

  return Column(
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
                    'Custos/Despesas',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: constroiCampo(
                                      labelCampo: 'Identificação',
                                      largura: 150,
                                      altura: 30,
                                      obrigaCampo: true,
                                      mascara: new MaskedTextController(
                                        mask: mascaraIdentificao,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: constroiCampo(
                                        labelCampo: 'Detalhes',
                                        largura: 250,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RequiredLabel(
                                        'Modalidade',
                                        true,
                                      ),
                                      Container(
                                        child:
                                            DropDown(valores: modalidadeCusto),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 68.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RequiredLabel(
                                          'Periodicidade',
                                          true,
                                        ),
                                        Container(
                                          child:
                                              DropDown(valores: periodoCusto),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RequiredLabel(
                                          'Análise Gerencial',
                                          true,
                                        ),
                                        Container(
                                          child:
                                              DropDown(valores: consideraAgr),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: constroiCampo(
                                      labelCampo: 'Valor',
                                      largura: 80,
                                      altura: 30,
                                      obrigaCampo: false,
                                      mascara: new MaskedTextController(
                                        mask: mascaraIdentificao,
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
  );
}

Widget constroiCampo({
  String labelCampo,
  double largura,
  double altura,
  bool obrigaCampo,
  TextEditingController mascara,
  //int tamanhoMaximo,
}) {
  return Form(
    child: AppTextField(
      label: labelCampo,
      width: largura,
      heigth: altura,
      required: obrigaCampo,
      controller: mascara,
      //tamanhoMaximo: tamanhoMaximo,
    ),
  );
}

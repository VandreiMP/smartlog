import 'package:flutter/material.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';
class ScreenEmbalagem extends StatefulWidget {
  @override
  _ScreenEmbalagem createState() => _ScreenEmbalagem();
}

class _ScreenEmbalagem extends State<ScreenEmbalagem> {
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
                caminhoImagem: "Images/embalagem.png",
                nomeFormulario: "Cadastro de Embalagens",
                origem: 'GERAL',
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
  List<String> tipoEmbalagens = [
    'Forma',
    'Caixa',
    'Pallet',
  ];

  List<String> tipoCapacidade = [
    'Unidade (Ovos)',
    'Forma',
    'Caixa',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                child: constroiCampo(
                                    labelCampo: 'Identificação',
                                    largura: 100,
                                    altura: 30,
                                    obrigaCampo: true),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  constroiCampo(
                                    labelCampo: 'Descrição',
                                    largura: 500,
                                    altura: 30,
                                    obrigaCampo: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RequiredLabel(
                                          'Categ.',
                                          true,
                                        ),
                                        Container(
                                          child:
                                              DropDown(valores: tipoEmbalagens),
                                        ),
                                      ],
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
                    'Capacidade e Dimensões',
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
                                    child: constroiCampo(
                                        labelCampo: 'Capacidade',
                                        largura: 100,
                                        altura: 30,
                                        obrigaCampo: true),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RequiredLabel(
                                          'Unidade',
                                          true,
                                        ),
                                        Container(
                                          child:
                                              DropDown(valores: tipoCapacidade),
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
                                      alignment: Alignment.centerRight,
                                      child: constroiCampo(
                                        labelCampo: 'Largura',
                                        largura: 70,
                                        altura: 30,
                                        obrigaCampo: false,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                    ),
                                    child: constroiCampo(
                                        labelCampo: 'Comprimento',
                                        largura: 70,
                                        altura: 30,
                                        obrigaCampo: false),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20.0,
                                    ),
                                    child: constroiCampo(
                                        labelCampo: 'Tara',
                                        largura: 70,
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

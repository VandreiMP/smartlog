import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

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
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CriaCardAuxiliar(
                  caminhoImagem: "Images/veiculo.png",
                  nomeFormulario: "Cadastro de Frota",
                  origem: 'DETALHES_CAMINHAO',),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      constroiCampo(
                                          labelCampo: 'Cor',
                                          largura: 100,
                                          altura: 30,
                                          obrigaCampo: false),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: constroiCampo(
                                          labelCampo: 'Km/L',
                                          largura: 80,
                                          altura: 30,
                                          obrigaCampo: false,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: constroiCampo(
                                          labelCampo: 'Capac.(Kg)',
                                          largura: 80,
                                          altura: 30,
                                          obrigaCampo: false,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: constroiCampo(
                                          labelCampo: 'Peso vazio',
                                          largura: 80,
                                          altura: 30,
                                          obrigaCampo: false,
                                          mascara: new MaskedTextController(
                                            mask: mascaraRenavam,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: constroiCampo(
                                          labelCampo: 'Eixos',
                                          largura: 60,
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
                                          altura: 30,
                                          obrigaCampo: false),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AppText(
                                          '*',
                                          bold: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: constroiCampo(
                                          labelCampo: 'Alt.(Mt)',
                                          largura: 80,
                                          altura: 30,
                                          obrigaCampo: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AppText(
                                          '*',
                                          bold: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: constroiCampo(
                                          labelCampo: 'Larg.(Mt)',
                                          largura: 80,
                                          altura: 30,
                                          obrigaCampo: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AppText(
                                          '=',
                                          bold: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: constroiCampo(
                                            labelCampo: 'Cubagem',
                                            largura: 80,
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
                    Container(
                      child: AppText(
                        'Agenda de Manutenções',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          //width: 466,
                          //height: 150.0,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: new Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Row(children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    constroiCampo(
                                      labelCampo: 'Rev.',
                                      largura: 85,
                                      altura: 30,
                                      obrigaCampo: false,
                                      mascara: new MaskedTextController(
                                        mask: mascaraData,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: constroiCampo(
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 50.0),
                                      child: constroiCampo(
                                        labelCampo: 'Óleo',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: constroiCampo(
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    constroiCampo(
                                      labelCampo: 'Pneu',
                                      largura: 85,
                                      altura: 30,
                                      obrigaCampo: false,
                                      mascara: new MaskedTextController(
                                        mask: mascaraData,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: constroiCampo(
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 50.0),
                                      child: constroiCampo(
                                        labelCampo: 'Freios',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: constroiCampo(
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    constroiCampo(
                                      labelCampo: 'Luzes',
                                      largura: 85,
                                      altura: 30,
                                      obrigaCampo: false,
                                      mascara: new MaskedTextController(
                                        mask: mascaraData,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25.0),
                                      child: constroiCampo(
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 50.0),
                                      child: constroiCampo(
                                        labelCampo: 'Sist. Elétrico',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 13.0),
                                      child: constroiCampo(
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraData,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ]),
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

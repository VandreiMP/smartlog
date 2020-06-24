import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../Components/scroll/scroll.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../funcoes/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenRespEmpresa extends StatefulWidget {
  @override
  _ScreenRespEmpresa createState() => _ScreenRespEmpresa();
}

class _ScreenRespEmpresa extends State<ScreenRespEmpresa> {
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
                caminhoImagem: "Images/enterprise.png",
                nomeFormulario: "Responável pela Empresa",
                origem: 'RESPONSAVEL',
              ),
              // CriaCardAjudaCaminhao(),
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
                        'Informações do Responsável',
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
                                          labelCampo: 'Nome',
                                          largura: 500,
                                          altura: 30,
                                          obrigaCampo: true),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      constroiCampo(
                                        labelCampo: 'RG',
                                        largura: 100,
                                        altura: 30,
                                        obrigaCampo: true,
                                        mascara: new MaskedTextController(
                                          mask: mascaraRg,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'CPF',
                                          largura: 120,
                                          altura: 30,
                                          obrigaCampo: true,
                                          mascara: new MaskedTextController(
                                            mask: mascaraCpf,
                                          ),
                                        ),
                                      ),
                                       Padding(
                                         padding: const EdgeInsets.only(left:8.0),
                                         child: constroiCampo(
                                          labelCampo: 'Função/Cargo',
                                          largura: 200,
                                          altura: 30,
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
                                        labelCampo: 'E-Mail',
                                        largura: 300,
                                        altura: 30,
                                        obrigaCampo: false,
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

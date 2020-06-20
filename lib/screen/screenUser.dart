import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/constantes/mascaras.dart';
import 'package:smartlogproject/funcoes/appText.dart';
import 'package:smartlogproject/funcoes/appTextField.dart';
import 'package:smartlogproject/funcoes/criaCardAuxiliar.dart';
import 'package:smartlogproject/funcoes/criaLista.dart';
import 'package:smartlogproject/funcoes/requiredLabel.dart';
import 'package:smartlogproject/screen/screenPattern.dart';

class ScreenUser extends StatefulWidget {
  @override
  _ScreenUser createState() => _ScreenUser();
}

class _ScreenUser extends State<ScreenUser> {
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
                caminhoImagem: "Images/user_logo.png",
                nomeFormulario: "Cadastro de Usuários",
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
  List<String> usuarios = [
    'Funcionário',
    'Diretor',
    'Motorista',
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
                    'Informações de Identificação',
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
                                child: constroiCampo(
                                  labelCampo: 'Nome',
                                  largura: 500,
                                  altura: 30,
                                  obrigaCampo: true,
                                ),
                              ),
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
                                    padding: const EdgeInsets.only(left: 70.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RequiredLabel(
                                          'Tipo Usuário',
                                          true,
                                        ),
                                        Container(
                                          child: DropDown(valores: usuarios),
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
                                      labelCampo: 'Login',
                                      largura: 150,
                                      altura: 30,
                                      obrigaCampo: true,
                                    ),
                                  ),
                                  /*SizedBox(
                                    width: 360,
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: constroiCampo(
                                        labelCampo: 'Senha',
                                        largura: 150,
                                        altura: 30,
                                        obrigaCampo: true,
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
                  height: 20.0,
                ),
                Container(
                  child: AppText(
                    'Informações para Contato',
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
                                child: constroiCampo(
                                  labelCampo: 'E-Mail',
                                  largura: 500,
                                  altura: 30,
                                  obrigaCampo: false,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: constroiCampo(
                                    labelCampo: 'Telefone',
                                    largura: 110,
                                    altura: 30,
                                    obrigaCampo: false,
                                    mascara: new MaskedTextController(
                                      mask: mascaraTelefone,
                                    ),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      child: constroiCampo(
                                          labelCampo: 'Celular',
                                          largura: 112,
                                          altura: 30,
                                          obrigaCampo: false,
                                          mascara: new MaskedTextController(
                                            mask: mascaraCelular,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      child: constroiCampo(
                                        labelCampo: 'Ramal',
                                        largura: 112,
                                        altura: 30,
                                        obrigaCampo: false,
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

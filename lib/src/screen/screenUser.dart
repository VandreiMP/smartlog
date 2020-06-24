import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/user/user.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../funcoes/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

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
  bool selected = false;

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
                origemDado: 'USUARIO',
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

  /*
    Variáveis usadas para capturar o valor dos campos do formulário
    e salvar no banco
  */
  final tNome = TextEditingController();
  final tId = TextEditingController();
  final tTpUsuario = TextEditingController();
  final tLogin = TextEditingController();
  final tSenha = TextEditingController();
  final tEmail = TextEditingController();
  final tTelefone = TextEditingController();
  final tCelular = TextEditingController();
  final tRamal = TextEditingController();
  bool saved = false;

  return Scroll(
    height: double.infinity,
    // width: double.infinity,
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
                                    controller: tNome,
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
                                        controller: tId,
                                        mascara: new MaskedTextController(
                                          mask: mascaraIdentificao,
                                        ),
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
                                            'Tipo Usuário',
                                            true,
                                          ),
                                          Container(
                                            child: DropDown(
                                              valores: usuarios,
                                            ),
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
                                        controller: tLogin,
                                      ),
                                    ),
                                    /*SizedBox(
                                      width: 360,
                                    ),*/
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: constroiCampo(
                                          labelCampo: 'Senha',
                                          largura: 150,
                                          altura: 30,
                                          obrigaCampo: true,
                                          controller: tSenha,
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
                                    controller: tEmail,
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
                                      controller: tTelefone,
                                      mascara: new MaskedTextController(
                                        mask: mascaraTelefone,
                                      ),
                                    )),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Container(
                                        child: constroiCampo(
                                            labelCampo: 'Celular',
                                            largura: 112,
                                            altura: 30,
                                            obrigaCampo: false,
                                            controller: tCelular,
                                            mascara: new MaskedTextController(
                                              mask: mascaraCelular,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Container(
                                        child: constroiCampo(
                                          labelCampo: 'Ramal',
                                          largura: 112,
                                          altura: 30,
                                          obrigaCampo: false,
                                          controller: tRamal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: AppText(
                      'Painel de Opções',
                      bold: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: new Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                print('1');
                                saved = true;
                                UserDao.salvarDados(
                                  tNome.text,
                                  tId.text,
                                  tTpUsuario.text,
                                  tLogin.text,
                                  tSenha.text,
                                  tEmail.text,
                                  tTelefone.text,
                                  tCelular.text,
                                  tRamal.text,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                  child: Chip(
                                    backgroundColor: Colors.white,
                                    label: Text('Salvar'),
                                    labelStyle: TextStyle(color: Colors.white),
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.black45,
                                      child: Icon(
                                        Icons.save,
                                        size: 10.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // child: Icon(
                                  //   Icons.save,
                                  //   size: 25.0,
                                  //   color: Colors.white,
                                  // ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (saved == false) {
                                  print('dados não salvos');
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   color: Colors.blue[900],
                                  //   borderRadius: BorderRadius.all(
                                  //     Radius.circular(2.0),
                                  //   ),
                                  // ),
                                  child: Icon(
                                    Icons.close,
                                    size: 25.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
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
  double largura,
  double altura,
  bool obrigaCampo,
  TextEditingController mascara,
  controller,
  //int tamanhoMaximo,
}) {
  return Form(
    child: AppTextField(
      label: labelCampo,
      width: largura,
      heigth: altura,
      required: obrigaCampo,
      controller: controller,
      //tamanhoMaximo: tamanhoMaximo,
    ),
  );
}

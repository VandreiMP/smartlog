import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/Entidades/classes/usuario.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

class ScreenArguments {
  final String identificacao;

  ScreenArguments(this.identificacao);
}

class ScreenUser extends StatelessWidget {
  Widget build(BuildContext context) {
   // print('antes screenUser${ModalRoute.of(context).settings.arguments}');
    // final ScreenArguments arguments = ModalRoute.of(context).settings.arguments;
  //  print('depois ScreenUser');
    // print('screenUser${arguments}');
    return ScreenPattern(
      child: Body(ModalRoute.of(context).settings.arguments),
    );
  }
}

class Body extends StatelessWidget {
  const Body(this.argument);

  final String argument;

  Widget build(BuildContext context) {
    String nomeFuncionario;

    // UsuarioBloc usuarioBloc = UsuarioBloc(context);
    // print('antes');

   //nomeFuncionario = usuarioBloc.getFuncionario(argument).getNome;
   
    return Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0),
      child: BlocProvider<UsuarioBloc>(
        bloc: UsuarioBloc(context),
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
            CriaCardFormulario(nomeFuncionario)
          ],
        ),
      ),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  List<String> usuarios = [
    'Funcionário',
    'Diretor',
    'Motorista',
  ];

  CriaCardFormulario(this.funcionario);

  final String funcionario;

  /*
    Variáveis usadas para capturar o valor dos campos do formulário
    e salvar no banco
  */
  final tNome = TextEditingController();
  final tId = TextEditingController();
  final tTpUsuario = TextEditingController();
  final tLogin = TextEditingController();
  final tEmailLogin = TextEditingController();
  final tSenha = TextEditingController();
  final tEmail = TextEditingController();
  final tTelefone = TextEditingController();
  final tCelular = TextEditingController();
  final tRamal = TextEditingController();
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    UsuarioBloc blocUsuario = BlocProvider.of<UsuarioBloc>(context);
    return StreamBuilder<Object>(
        stream: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                        Container(
                                          child: constroiCampo(
                                            labelCampo: 'Nome',
                                            largura: 500,
                                            altura: 30,
                                            contextoAplicacao: context,
                                            obrigaCampo: true,
                                            // valorInicial: 'teste',
                                            controller: tNome
                                              ..text = 'funcionario.nome',
                                            onChanged: (String valor) {
                                            //  print('controller${tNome.text}');
                                              blocUsuario.setNome(tNome.text);
                                            },
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                contextoAplicacao: context,
                                                controller: tId,
                                                onChanged: (String valor) {
                                                  blocUsuario.setId(tId.text);
                                                },
                                                mascara:
                                                    new MaskedTextController(
                                                  mask: mascaraIdentificao,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 70.0),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: constroiCampo(
                                                labelCampo: 'E-Mail Acesso',
                                                contextoAplicacao: context,
                                                largura: 350,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tEmailLogin,
                                                onChanged: (String valor) {
                                                  blocUsuario.setEmailLogin(
                                                      tEmailLogin.text);
                                                },
                                              ),
                                            ),
                                            /*SizedBox(
                                              width: 360,
                                            ),*/
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: constroiCampo(
                                                  labelCampo: 'Senha',
                                                  largura: 150,
                                                  altura: 30,
                                                  contextoAplicacao: context,
                                                  obrigaCampo: true,
                                                  controller: tSenha,
                                                  onChanged: (String valor) {
                                                    blocUsuario
                                                        .setSenha(tSenha.text);
                                                  },
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
                                        Container(
                                          child: constroiCampo(
                                            labelCampo: 'E-Mail Alternativo',
                                            largura: 500,
                                            altura: 30,
                                            contextoAplicacao: context,
                                            obrigaCampo: false,
                                            controller: tEmail,
                                            onChanged: (String valor) {
                                             blocUsuario.setEmail(tEmail.text);
                                            },
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: constroiCampo(
                                                labelCampo: 'Telefone',
                                                largura: 110,
                                                altura: 30,
                                                contextoAplicacao: context,
                                                obrigaCampo: false,
                                                controller: tTelefone,
                                                onChanged: (String valor) {
                                                  blocUsuario.setTelefone(
                                                      tTelefone.text);
                                                },
                                                mascara:
                                                    new MaskedTextController(
                                                  mask: mascaraTelefone,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Container(
                                                child: constroiCampo(
                                                  labelCampo: 'Celular',
                                                  largura: 112,
                                                  altura: 30,
                                                  contextoAplicacao: context,
                                                  obrigaCampo: false,
                                                  controller: tCelular,
                                                  onChanged: (String valor) {
                                                    blocUsuario.setCelular(
                                                        tCelular.text);
                                                  },
                                                  // mascara:
                                                  //     new MaskedTextController(
                                                  //   mask: mascaraCelular,
                                                  // ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Container(
                                                child: constroiCampo(
                                                  labelCampo: 'Ramal',
                                                  largura: 112,
                                                  altura: 30,
                                                  contextoAplicacao: context,
                                                  obrigaCampo: false,
                                                  controller: tRamal,
                                                  onChanged: (String valor) {
                                                    // print(tRamal.text);
                                                    blocUsuario
                                                        .setRamal(tRamal.text);
                                                    // print(1213);
                                                    // blocUsuario
                                                    //     .insertOrUpdate();
                                                    var usuario = Usuario();

                                                    // print(usuario.ramal);
                                                  },
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
                          // Row(
                          //   children: [
                          //     Container(
                          //       padding: EdgeInsets.all(10.0),
                          //       decoration: BoxDecoration(
                          //         color: Colors.white,
                          //         borderRadius: BorderRadius.all(Radius.circular(5)),
                          //         border: new Border.all(
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //       child: Row(
                          //         children: [
                          //           GestureDetector(
                          //             onTap: () {
                          //               // print('1');
                          //               // saved = true;
                          //               // blocUsuario
                          //               //     .setRamal(tRamal.text as int);
                          //               // blocUsuario.insertOrUpdate();
                          //               // UserDao.salvarDados(
                          //               //   tNome.text,
                          //               //   tId.text,
                          //               //   tTpUsuario.text,
                          //               //   tLogin.text,
                          //               //   tSenha.text,
                          //               //   tEmail.text,
                          //               //   tTelefone.text,
                          //               //   tCelular.text,
                          //               //   tRamal.text,
                          //               // );
                          //             },
                          //             child: CircleAvatar(
                          //               backgroundColor: Colors.black45,
                          //               child: Icon(
                          //                 Icons.save,
                          //                 size: 10.0,
                          //                 color: Colors.white,
                          //               ),
                          //             ),

                          //             // child: Icon(
                          //             //   Icons.save,
                          //             //   size: 25.0,
                          //             //   color: Colors.white,
                          //             // ),
                          //           ),
                          //           SizedBox(
                          //             width: 10.0,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              //   );
              // }),
            ),
          );
        });
  }

  // Widget constroiCampo({
  //   String labelCampo,
  //   Function onChanged,
  //   double largura,
  //   double altura,
  //   bool obrigaCampo,
  //   TextEditingController mascara,
  //   controller,
  //   //int tamanhoMaximo,
  // }) {
  //   return Form(
  //     child: AppTextField(
  //       label: labelCampo,
  //       width: largura,
  //       onChanged: onChanged,
  //       heigth: altura,
  //       required: obrigaCampo,
  //       controller: controller,
  //       //tamanhoMaximo: tamanhoMaximo,
  //     ),
  //   );
  // }

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
    //int tamanhoMaximo,
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
              //maxLength: tamanhoMaximo,
              cursorColor: Colors.black,
              // initialValue: valorInicial,
              // onFieldSubmitted: onChanged,
              //key: Key(label),
              controller: controller,
              // obscureText: password,
              // validator: validator,
              // keyboardType: keyboardType,
              // textInputAction: textInputAction,
              // focusNode: focusNode,
              onChanged: onChanged,
              // onFieldSubmitted: (String text) {
              //   if (nextFocus != null) {
              //     FocusScope.of(context).requestFocus(nextFocus);
              //   }
              // },
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  /*border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16)
       ),*/
                  /*labelText: label,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),*/
                  /*hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14,
          ),*/
                  ),
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

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/constantes/mascaras.dart';
import 'package:smartlogproject/src/funcoes/appText.dart';
import 'package:smartlogproject/src/funcoes/buscaFuncionarios.dart';
import 'package:smartlogproject/src/funcoes/criaLista.dart';
import 'package:smartlogproject/src/funcoes/requiredLabel.dart';
import 'package:smartlogproject/src/screen/screenPattern.dart';

class ListaFuncionarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: BlocProvider(
          bloc: UsuarioBloc(context),
          child:
              //  Row(
              //   children: [
              // Column(
              //   children: [
              //     BuscaFuncionarios(),
              //   ],
              // ),
              CriaCardFormulario()
          //     ],
          //   ),
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
                        'Filtros para Consulta',
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
                                  Container(
                                    child: constroiCampo(
                                      labelCampo: 'Nome',
                                      largura: 500,
                                      altura: 30,
                                      contextoAplicacao: context,
                                      obrigaCampo: false,
                                      controller: tNome,
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
                                          obrigaCampo: false,
                                          contextoAplicacao: context,
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
                                              false,
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
                        'Lista de Funcionários',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        BuscaFuncionarios(),
                      ],
                    )
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

  Widget constroiCampo(
      {String labelCampo,
      Function onChanged,
      double largura,
      double altura,
      bool obrigaCampo,
      BuildContext contextoAplicacao,
      TextEditingController mascara,
      TextEditingController controller
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
              //maxLength: tamanhoMaximo,
              maxLengthEnforced: true,
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

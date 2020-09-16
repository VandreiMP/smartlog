import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
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
      child: BlocProvider<EmbalagemBloc>(
        bloc: EmbalagemBloc(context),
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
                  origemDado: 'EMBALAGEM',
                ),
                // CriaCardAjuda(),
              ],
            ),
            CriaCardFormulario()
          ],
        ),
      ),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  List<String> tipoEmbalagens = [
    'Forma',
    'Caixa',
    'Pallet',
  ];
  List<String> tipoCapacidade = [
    'Ovos',
    'Forma',
    'Caixa',
  ];

  /*
    Variáveis usadas para capturar o valor dos campos do formulário
    e salvar no banco
  */
  final tDescricao = TextEditingController();
  final tId = TextEditingController();
  final tCategoriaEmbalagem = TextEditingController();
  final tCapacidade = TextEditingController();
  final tTipoUnidade = TextEditingController();
  final tLargura = TextEditingController();
  final tComprimento = TextEditingController();
  final tAltura = TextEditingController();
  final tTara = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EmbalagemBloc blocEmbalagem = BlocProvider.of<EmbalagemBloc>(context);
    return StreamBuilder<Object>(
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
                                          alignment: Alignment.topLeft,
                                          child: constroiCampo(
                                            labelCampo: 'Identificação',
                                            largura: 100,
                                            altura: 30,
                                            controller: tId,
                                            onChanged: (String valor) {
                                              blocEmbalagem.setId(tId.text);
                                            },
                                            obrigaCampo: true,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Descrição',
                                              largura: 500,
                                              altura: 30,
                                              obrigaCampo: true,
                                              controller: tDescricao,
                                              onChanged: (String valor) {
                                                blocEmbalagem.setDescricao(
                                                    tDescricao.text);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
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
                                                    child: DropDown(
                                                        valores:
                                                            tipoEmbalagens),
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
                                            Container(
                                              child: constroiCampo(
                                                labelCampo: 'Capacidade',
                                                largura: 100,
                                                altura: 30,
                                                controller: tCapacidade,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setCapacidade(
                                                      tCapacidade.text);
                                                },
                                                obrigaCampo: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
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
                                                    child: DropDown(
                                                        valores:
                                                            tipoCapacidade),
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
                                                alignment:
                                                    Alignment.centerRight,
                                                child: constroiCampo(
                                                  labelCampo: 'Largura',
                                                  largura: 70,
                                                  altura: 30,
                                                  controller: tLargura,
                                                  onChanged: (String valor) {
                                                    blocEmbalagem.setLargura(
                                                        tLargura.text);
                                                  },
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
                                                controller: tComprimento,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setComprimento(
                                                      tComprimento.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                labelCampo: 'Altura',
                                                largura: 70,
                                                altura: 30,
                                                controller: tAltura,
                                                onChanged: (String valor) {
                                                  blocEmbalagem.setAltura(
                                                      tAltura.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                              ),
                                              child: constroiCampo(
                                                  labelCampo: 'Tara',
                                                  largura: 70,
                                                  altura: 30,
                                                  controller: tTara,
                                                  onChanged: (String valor) {
                                                    blocEmbalagem
                                                        .setTara(
                                                            tTara.text);
                                                  },
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
            ),
          );
        });
  }

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

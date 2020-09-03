import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

class ScreenAbastecimento extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Body(),
    );
  }
}

class Body extends StatelessWidget {
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
                caminhoImagem: "Images/combustivel.png",
                nomeFormulario: "Solicitação de Abastecimento",
                origem: 'GERAL',
                origemDado: 'COMBUSTIVEL',
              ),
              // CriaCardAjuda(),
            ],
          ),
          CriaCardFormulario()
        ],
      ),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  /*
    Variáveis usadas para capturar o valor dos campos do formulário
    e salvar no banco
  */
  final tDetalhes = TextEditingController();
  final tId = TextEditingController();
  final tSituacao = TextEditingController();
  final tSolicitante = TextEditingController();
  final tDataAbertura = TextEditingController();
  final tDataEfetivacao = TextEditingController();
  final tPosto = TextEditingController();
  final tPrecoLitro = TextEditingController();
  final tQuantidade = TextEditingController();
  final tCustoTotal = TextEditingController();
  final tCustoVinculado = TextEditingController();
  bool saved = false;

  List<String> situacaoSolicitacao = [
    'Aberta',
    'Pendente',
    'Cancelada',
    'Negada',
    'Efetivada',
  ];

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
                        'Cabeçalho',
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
                                    children: [
                                      Container(
                                        child: constroiCampo(
                                          labelCampo: 'Identificação',
                                          largura: 150,
                                          altura: 30,
                                          contextoAplicacao: context,
                                          obrigaCampo: true,
                                          controller: tId,
                                          onChanged: (String valor) {},
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
                                          labelCampo: 'Detalhes',
                                          largura: 500,
                                          altura: 30,
                                          obrigaCampo: true,
                                          contextoAplicacao: context,
                                          controller: tDetalhes,
                                          onChanged: (String valor) {},
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
                                              'Situação',
                                              true,
                                            ),
                                            Container(
                                              child: DropDown(
                                                valores: situacaoSolicitacao,
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
                                          labelCampo: 'Solicitante',
                                          contextoAplicacao: context,
                                          largura: 350,
                                          altura: 30,
                                          obrigaCampo: true,
                                          controller: tSolicitante,
                                          onChanged: (String valor) {},
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Data Abertura',
                                          largura: 85,
                                          altura: 30,
                                          obrigaCampo: true,
                                          controller: tDataAbertura,
                                          mascara: new MaskedTextController(
                                            mask: mascaraData,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Data Efetivação',
                                          largura: 85,
                                          altura: 30,
                                          obrigaCampo: false,
                                          controller: tDataEfetivacao,
                                          mascara: new MaskedTextController(
                                            mask: mascaraData,
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
                        'Informações do Abastecimento',
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
                                      labelCampo: 'Posto',
                                      largura: 500,
                                      altura: 30,
                                      contextoAplicacao: context,
                                      obrigaCampo: true,
                                      controller: tPosto,
                                      onChanged: (String valor) {},
                                    ),
                                  ),
                                  
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: constroiCampo(
                                          labelCampo: 'Preço p/ Litro',
                                          largura: 85,
                                          altura: 30,
                                          controller: tPrecoLitro,
                                          obrigaCampo: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AppText(
                                          '   *',
                                          bold: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Quantidade(Lt)',
                                          largura: 85,
                                          altura: 30,
                                          controller: tQuantidade,
                                          obrigaCampo: false,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AppText(
                                          '   =',
                                          bold: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                            labelCampo: 'Custo Total',
                                            largura: 85,
                                            altura: 30,
                                            obrigaCampo: false,
                                            controller: tCustoTotal),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Custo Vinculado',
                                          largura: 100,
                                          altura: 30,
                                          controller: tCustoVinculado,
                                          obrigaCampo: false,
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

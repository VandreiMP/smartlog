import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/funcoes/criaLista.dart';
import 'package:smartlogproject/src/funcoes/requiredLabel.dart';
import '../Components/scroll/scroll.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenContrato extends StatefulWidget {
  @override
  _ScreenContrato createState() => _ScreenContrato();
}

class _ScreenContrato extends State<ScreenContrato> {
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
          Scroll(
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/contrato_venda.png",
                  nomeFormulario: "Contrato de Venda",
                  origem: 'CONTRATO',
                ),
                // CriaCardAjudaCaminhao(),
              ],
            ),
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
    List<String> situacaoContrato = [
      'Ativa',
      'Encerrada',
      'Cancelada',
    ];

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      constroiCampo(
                                        labelCampo: 'Contrato',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Data Emissão',
                                          largura: 85,
                                          altura: 30,
                                          obrigaCampo: true,
                                          mascara: new MaskedTextController(
                                            mask: mascaraData,
                                          ),
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
                                        labelCampo: 'CNPJ/CPF',
                                        largura: 150,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo:
                                              'Razão Social do Comprador',
                                          largura: 300,
                                          altura: 30,
                                          obrigaCampo: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: Container(
                                          child: constroiCampo(
                                            labelCampo: 'Telefone',
                                            largura: 110,
                                            altura: 30,
                                            obrigaCampo: false,
                                            mascara: new MaskedTextController(
                                              mask: mascaraTelefone,
                                            ),
                                          ),
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
                                        child: constroiCampo(
                                          labelCampo: 'E-Mail',
                                          largura: 500,
                                          altura: 30,
                                          obrigaCampo: false,
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
                      height: 10.0,
                    ),
                    Container(
                      child: AppText(
                        'Mercadoria',
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
                                        labelCampo: 'Produto',
                                        largura: 300,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Embalagem',
                                          largura: 200,
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
                                      AppText(
                                        '( ',
                                        bold: true,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0.0),
                                        child: constroiCampo(
                                          labelCampo: 'Preço Bruto',
                                          largura: 85,
                                          altura: 30,
                                          obrigaCampo: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AppText(
                                          '   -',
                                          bold: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Desconto',
                                          largura: 75,
                                          altura: 30,
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
                                          labelCampo: 'Preço Líq.',
                                          largura: 85,
                                          altura: 30,
                                          obrigaCampo: true,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: AppText(
                                          ')      *',
                                          bold: true,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
                                        child: constroiCampo(
                                          labelCampo: 'Quantidade',
                                          largura: 85,
                                          altura: 30,
                                          obrigaCampo: true,
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
                                            const EdgeInsets.only(left: 30.0),
                                        child: constroiCampo(
                                          labelCampo: 'Total Contrato',
                                          largura: 85,
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
                                        labelCampo: 'Previsão Entrega',
                                        largura: 85,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25.0),
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
                                                  valores: situacaoContrato),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pushNamed(
                                                      '/FormularioDespesasContrato');
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[900],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(2.0),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.attach_money,
                                                    size: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
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

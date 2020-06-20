import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/constantes/mascaras.dart';
import 'package:smartlogproject/funcoes/appText.dart';
import 'package:smartlogproject/funcoes/appTextField.dart';
import 'package:smartlogproject/funcoes/criaCardAuxiliar.dart';
import 'package:smartlogproject/funcoes/criaLista.dart';
import 'package:smartlogproject/funcoes/requiredLabel.dart';
import 'package:smartlogproject/screen/screenPattern.dart';

class ScreenCaminhao extends StatefulWidget {
  @override
  _ScreenCaminhao createState() => _ScreenCaminhao();
}

class _ScreenCaminhao extends State<ScreenCaminhao> {
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
                origem: 'ADICIONAIS',
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
    List<String> tipoCarroceria = [
      'Aberta',
      'Baú',
      'Granelera',
      'Porta Container',
      'Sider',
      'Tanque',
      'Outros'
    ];

    List<String> tipoVeiculo = [
      'Caminhão Leve (3,5T A 7,99T)',
      'Caminhão Simples (8T A 29T)',
      'Caminhão Trator',
      'Caminhão Trator Especial',
      'Caminhote / Furgão (1,5T A 3,49T)',
      'Reboque',
      'Semi-Reboque',
      'Semi-Reboque c/ 5 Roda / Bitrem',
      'Semi-Reboque Especial',
      'Utilitário Leve (0,5T A 1,49T)',
      'Veículo Operacional de Apoio'
    ];

    List<String> tipoCombustivel = [
      'Diesel',
      'Gasolina',
      'Etanol',
      'Flex',
      'GLP',
      'Outros'
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    constroiCampo(
                                        labelCampo: 'Placa',
                                        largura: 100,
                                        altura: 30,
                                        obrigaCampo: true),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: constroiCampo(
                                        labelCampo: 'Ano',
                                        largura: 40,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: constroiCampo(
                                        labelCampo: 'UF',
                                        largura: 50,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:100.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RequiredLabel(
                                            'Categoria do Veículo',
                                            true,
                                          ),
                                          Container(
                                            child:
                                                DropDown(valores: tipoVeiculo),
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
                                    constroiCampo(
                                      labelCampo: 'Descrição',
                                      largura: 500,
                                      altura: 30,
                                      obrigaCampo: true,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pushNamed(
                                                      '/FormularioCaminhaoDetalhes');
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
                                                    Icons.local_shipping,
                                                    size: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: GestureDetector(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[900],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(2.0),
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: GestureDetector(
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    constroiCampo(
                                      labelCampo: 'Modelo',
                                      largura: 150,
                                      altura: 30,
                                      obrigaCampo: false,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: constroiCampo(
                                        labelCampo: 'Fabricante',
                                        largura: 150,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RequiredLabel(
                                            'Carroceria',
                                            true,
                                          ),
                                          Container(
                                            child: DropDown(
                                                valores: tipoCarroceria),
                                          ),
                                        ],
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
                      'Informações Específicas',
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
                                    constroiCampo(
                                        labelCampo: 'Chassi',
                                        largura: 100,
                                        altura: 30,
                                        obrigaCampo: true),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 70.0),
                                      child: constroiCampo(
                                        labelCampo: 'Renavam',
                                        largura: 110,
                                        altura: 30,
                                        obrigaCampo: true,
                                        mascara: new MaskedTextController(
                                          mask: mascaraRenavam,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 70.0),
                                      child: constroiCampo(
                                        labelCampo: 'RNTRC',
                                        largura: 100,
                                        altura: 30,
                                        obrigaCampo: true,
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
                                            'Combust.',
                                            true,
                                          ),
                                          Container(
                                            child: DropDown(
                                                valores: tipoCombustivel),
                                          ),
                                        ],
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

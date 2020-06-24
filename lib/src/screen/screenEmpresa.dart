import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../funcoes/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

class ScreenEmpresa extends StatefulWidget {
  @override
  _ScreenEmpresa createState() => _ScreenEmpresa();
}

class _ScreenEmpresa extends State<ScreenEmpresa> {
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
                nomeFormulario: "Cadastro de Empresa",
                origem: 'EMPRESA',
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
    List<String> atividadeEmpresa = [
      'Comércio',
      'Indústria',
      'Prest. Serviço',
    ];

    return Scroll(
      height: double.infinity,
      //width: double.infinity,
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
                                          labelCampo: 'Identificação',
                                          largura: 150,
                                          altura: 30,
                                          obrigaCampo: true),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'Razão Social',
                                          largura: 500,
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
                                        labelCampo: 'Nome Fantasia',
                                        largura: 500,
                                        altura: 30,
                                        obrigaCampo: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                '/FormularioEmpresaDetalhes');
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue[900],
                                              borderRadius: BorderRadius.all(
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
                        'Informações Específicas e Contatos',
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
                                    children: [
                                      constroiCampo(
                                        labelCampo: 'CNPJ',
                                        largura: 150,
                                        altura: 30,
                                        obrigaCampo: true,
                                        mascara: new MaskedTextController(
                                          mask: mascaraCnpj,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'Insc. Estadual',
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
                                              'Atividade',
                                              true,
                                            ),
                                            Container(
                                              child: DropDown(
                                                  valores: atividadeEmpresa),
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
                                    children: [
                                      constroiCampo(
                                        labelCampo: 'Telefone',
                                        largura: 110,
                                        altura: 30,
                                        obrigaCampo: false,
                                        mascara: new MaskedTextController(
                                          mask: mascaraTelefone,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'E-Mail',
                                          largura: 300,
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
                        'Endereços',
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
                                    children: [
                                      constroiCampo(
                                        labelCampo: 'Endereço',
                                        largura: 300,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'Cidade',
                                          largura: 200,
                                          altura: 30,
                                          obrigaCampo: false,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'UF',
                                          largura: 30,
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
                                    children: [
                                      constroiCampo(
                                        labelCampo: 'Bairro',
                                        largura: 200,
                                        altura: 30,
                                        obrigaCampo: false,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: constroiCampo(
                                          labelCampo: 'CEP',
                                          largura: 85,
                                          altura: 30,
                                          obrigaCampo: false,
                                          mascara: new MaskedTextController(
                                            mask: mascaraCep,
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

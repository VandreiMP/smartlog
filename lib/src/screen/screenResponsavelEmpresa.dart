import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Entidades/Bloc/empresa-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/responsavelEmpresa-bloc.dart';
import '../Components/scroll/scroll.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../funcoes/appTextField.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
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
      child: BlocProvider<ResponsavelEmpresaBloc>(
        bloc: ResponsavelEmpresaBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/enterprise.png",
                  nomeFormulario: "Responsável pela Empresa",
                  origem: 'RESPONSAVEL',
                  origemDado: 'RESPONSAVEL',
                  chaveConsulta: ModalRoute.of(context).settings.arguments,
                ),
                // CriaCardAjudaCaminhao(),
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
  final String caminhoImagem;
  final String nomeFormulario;

  const CriaCardFormulario({this.caminhoImagem, this.nomeFormulario});

  @override
  Widget build(BuildContext context) {
    /*
    Variáveis usadas para capturar o valor dos colunas do formulário
    e salvar no banco
    */
    final tIdEmpresa = TextEditingController();
    final tNome = TextEditingController();
    final tRg = MaskedTextController(mask: mascaraRg);
    final tcpf = MaskedTextController(mask: mascaraCpf);
    final tCargo = TextEditingController();
    final tEmail = TextEditingController();

    String codigoEmpresa = ModalRoute.of(context).settings.arguments;
    ResponsavelEmpresaBloc blocResponsavelEmpresa =
        BlocProvider.of<ResponsavelEmpresaBloc>(context);
    final Firestore firestore = Firestore.instance;

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */
    Future consultaDados(DocumentSnapshot coluna) async {
      if (coluna.exists == true) {
       
        if (codigoEmpresa.isNotEmpty) {
          tIdEmpresa.text = codigoEmpresa;
        }
        tNome.text = coluna.data['nome'];
        tRg.text = coluna.data['rg'];
        tcpf.text = coluna.data['cpf'];
        tCargo.text = coluna.data['cargo'];
        tEmail.text = coluna.data['email'];

        blocResponsavelEmpresa
            .setIdentificacaoResponsavelEmpresa(tIdEmpresa.text);
        blocResponsavelEmpresa.setRg(tRg.text);
        blocResponsavelEmpresa.setCpf(tcpf.text);
        blocResponsavelEmpresa.setCargo(tCargo.text);
        blocResponsavelEmpresa.setEmail(tEmail.text);
      }
    }

    if (codigoEmpresa != null) {
      firestore
          .collection("responsavelEmpresa")
          .document(codigoEmpresa)
          .get()
          .then(
            (coluna) async => consultaDados(coluna),
          );
    }

    return Scroll(
      height: double.infinity,
      child: StreamBuilder<ResponsavelEmpresaBloc>(
          stream: null,
          builder: (context, snapshot) {
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
                                            constroiCampo(
                                                labelCampo: 'Nome',
                                                largura: 500,
                                                altura: 30,
                                                controller: tNome,
                                                onChanged: (String valor) {
                                                  blocResponsavelEmpresa
                                                      .setIdentificacaoResponsavelEmpresa(
                                                          codigoEmpresa);
                                                  blocResponsavelEmpresa
                                                      .setNome(tNome.text);
                                                },
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
                                              controller: tRg,
                                              onChanged: (String valor) {
                                                blocResponsavelEmpresa
                                                    .setRg(tRg.text);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: constroiCampo(
                                                labelCampo: 'CPF',
                                                largura: 120,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tcpf,
                                                onChanged: (String valor) {
                                                  blocResponsavelEmpresa
                                                      .setCpf(tcpf.text);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: constroiCampo(
                                                labelCampo: 'Função/Cargo',
                                                largura: 200,
                                                altura: 30,
                                                controller: tCargo,
                                                onChanged: (String valor) {
                                                  blocResponsavelEmpresa
                                                      .setCargo(tCargo.text);
                                                },
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
                                              controller: tEmail,
                                              onChanged: (String valor) {
                                                blocResponsavelEmpresa
                                                    .setEmail(tEmail.text);
                                              },
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
            );
          }),
    );
  }
}

Widget constroiCampo({
  String labelCampo,
  double largura,
  double altura,
  bool obrigaCampo,
  TextEditingController controller,
  Function onChanged,
}) {
  return Form(
    child: AppTextField(
      label: labelCampo,
      onChanged: onChanged,
      width: largura,
      heigth: altura,
      required: obrigaCampo,
      controller: controller,
    ),
  );
}

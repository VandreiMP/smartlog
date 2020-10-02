import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoAbastecimento-bloc.dart';
import 'package:smartlogproject/src/funcoes/appTextField.dart';
import 'package:smartlogproject/src/funcoes/calculaCustoSolicitacao.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

class ScreenAbastecimento extends StatefulWidget {
  @override
  _ScreenAbastecimentoState createState() => _ScreenAbastecimentoState();
}

class _ScreenAbastecimentoState extends State<ScreenAbastecimento> {
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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0),
      child: BlocProvider<SolicitacaoAbastecimentoBloc>(
        bloc: SolicitacaoAbastecimentoBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/combustivel.png",
                  nomeFormulario: "Solicitação de Abastecimento",
                  origem: 'COMBUSTIVEL',
                  origemDado: 'COMBUSTIVEL',
                  chaveConsulta: ModalRoute.of(context).settings.arguments,
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
  @override
  Widget build(BuildContext context) {
    /*
    Variáveis usadas para capturar o valor dos campos do formulário
    e salvar no banco
  */
    final tDetalhes = TextEditingController();
    final tId = TextEditingController();
    final tSituacao = TextEditingController();
    final tSolicitante = TextEditingController();
    final tDataAbertura = MaskedTextController(mask: mascaraData);
    final tDataEfetivacao = MaskedTextController(mask: mascaraData);
    final tPosto = TextEditingController();
    final tTipoCombustivel = TextEditingController();
    final tPrecoLitro = TextEditingController();
    final tQuantidade = TextEditingController();
    final tCustoTotal = TextEditingController();
    final tCustoVinculado = TextEditingController();

    List<String> situacaoSolicitacao = [
      'Aberta',
      'Pendente',
      'Negada',
      'Efetivada',
    ];

    List<String> tipoCombustivel = [
      'Diesel',
      'Gasolina',
      'Etanol',
      'Flex',
      'GLP',
      'Outros'
    ];
    SolicitacaoAbastecimentoBloc blocSolicitacaoAbastecimento =
        BlocProvider.of<SolicitacaoAbastecimentoBloc>(context);
    String codigoSolicitacao = ModalRoute.of(context).settings.arguments;
    final Firestore firestore = Firestore.instance;
    bool campoHabilitado = true;

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */

    Future consultaDados(DocumentSnapshot coluna) async {
      if (codigoSolicitacao.isNotEmpty) {
        tId.text = codigoSolicitacao;
      }
      tDetalhes.text = coluna.data['detalhes'];
      tSolicitante.text = coluna.data['solicitante'];
      tDataAbertura.text = coluna.data['dataAbertura'];
      tDataEfetivacao.text = coluna.data['dataEfetivacao'];
      tPosto.text = coluna.data['posto'];
      tPrecoLitro.text = coluna.data['precoLitro'].toString();
      tQuantidade.text = coluna.data['quantidade'].toString();
      tCustoTotal.text = coluna.data['custoTotal'].toString();

      blocSolicitacaoAbastecimento.setId(tId.text);
      blocSolicitacaoAbastecimento.setDetalhes(tDetalhes.text);
      blocSolicitacaoAbastecimento.setSolicitante(tSolicitante.text);
      blocSolicitacaoAbastecimento.setDataAbertura(tDataAbertura.text);
      blocSolicitacaoAbastecimento.setDataEfetivacao(tDataEfetivacao.text);
      blocSolicitacaoAbastecimento.setPosto(tPosto.text);
      blocSolicitacaoAbastecimento
          .setPrecoLitro(double.parse(tPrecoLitro.text));
      blocSolicitacaoAbastecimento
          .setQuantidade(double.parse(tQuantidade.text));
      blocSolicitacaoAbastecimento
          .setCustoTotal(double.parse(tCustoTotal.text));
    }

    if (codigoSolicitacao != null) {
      campoHabilitado = false;
      firestore
          .collection("solicitacaoAbastecimento")
          .document(codigoSolicitacao)
          .get()
          .then((coluna) async => consultaDados(coluna));
    }

    return StreamBuilder<QuerySnapshot>(
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
                                          children: [
                                            Container(
                                              child: constroiCampo(
                                                labelCampo: 'Identificação',
                                                largura: 150,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tId,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setId(tId.text);
                                                },
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
                                                controller: tDetalhes,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setDetalhes(
                                                          tDetalhes.text);
                                                },
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
                                                    'Situação',
                                                    true,
                                                  ),
                                                  Container(
                                                    child: DropDown(
                                                      valores:
                                                          situacaoSolicitacao,
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
                                                  largura: 350,
                                                  altura: 30,
                                                  obrigaCampo: true,
                                                  controller: tSolicitante,
                                                  onChanged: (String valor) {
                                                    blocSolicitacaoAbastecimento
                                                        .setSolicitante(
                                                            tSolicitante.text);
                                                  }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Data Abertura',
                                                largura: 85,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tDataAbertura,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setDataAbertura(
                                                          tDataAbertura.text);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Data Efetivação',
                                                largura: 85,
                                                altura: 30,
                                                obrigaCampo: false,
                                                controller: tDataEfetivacao,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setDataEfetivacao(
                                                          tDataEfetivacao.text);
                                                },
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
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              constroiCampo(
                                                labelCampo: 'Posto',
                                                largura: 500,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tPosto,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setPosto(tPosto.text);
                                                },
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
                                                      'Combust.',
                                                      true,
                                                    ),
                                                    Container(
                                                      child: DropDown(
                                                          valores:
                                                              tipoCombustivel),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0.0),
                                              child: constroiCampo(
                                                labelCampo: 'Preço p/ Litro',
                                                largura: 85,
                                                altura: 30,
                                                controller: tPrecoLitro,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setPrecoLitro(
                                                          double.parse(
                                                              tPrecoLitro
                                                                  .text));
                                                  tCustoTotal.text =
                                                      calculaValorTotalSolicitacao(
                                                    double.parse(
                                                        tPrecoLitro.text),
                                                    double.parse(
                                                        tQuantidade.text),
                                                  ).toString();
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '   *',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Quantidade(Lt)',
                                                largura: 85,
                                                altura: 30,
                                                controller: tQuantidade,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoAbastecimento
                                                      .setQuantidade(
                                                          double.parse(
                                                              tQuantidade
                                                                  .text));
                                                  tCustoTotal.text =
                                                      calculaValorTotalSolicitacao(
                                                    double.parse(
                                                        tPrecoLitro.text),
                                                    double.parse(
                                                        tQuantidade.text),
                                                  ).toString();
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: AppText(
                                                '   =',
                                                bold: true,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Custo Total',
                                                largura: 85,
                                                altura: 30,
                                                controller: tCustoTotal,
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
                                              labelCampo: 'Custo Vinculado',
                                              largura: 450,
                                              altura: 30,
                                              controller: tCustoVinculado,
                                              onChanged: (String valor) {
                                                blocSolicitacaoAbastecimento
                                                    .setCustoVinculado(
                                                        tCustoVinculado.text);
                                              },
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                '/ListaValoresCusto');
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.blue[900],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                2.0),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 25.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
    double largura,
    double altura,
    bool obrigaCampo,
    Function onChanged,
    TextEditingController controller,
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
}

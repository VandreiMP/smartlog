import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoManutencao-bloc.dart';
import 'package:smartlogproject/src/funcoes/appTextField.dart';
import '../funcoes/appText.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

class ScreenManutencao extends StatefulWidget {
  @override
  _ScreenManutencaoState createState() => _ScreenManutencaoState();
}

class _ScreenManutencaoState extends State<ScreenManutencao> {
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
      child: BlocProvider<SolicitacaoManutencaoBloc>(
        bloc: SolicitacaoManutencaoBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/manutencao.png",
                  nomeFormulario: "Programação de Manutenção",
                  origem: 'MANUTENCAO',
                  origemDado: 'MANUTENCAO',
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
    final tTipoManutencao = TextEditingController();
    final tSituacao = TextEditingController();
    final tSolicitante = TextEditingController();
    final tDataAbertura = TextEditingController();
    final tDataEfetivacao = TextEditingController();
    final tOficina = TextEditingController();
    final tFornecedor = TextEditingController();
    final tQuantidade = TextEditingController();
    final tCustoTotal = TextEditingController();
    final tCustoVinculado = TextEditingController();

    List<String> situacaoSolicitacao = [
      'Aberta',
      'Negada',
      'Efetivada',
    ];

    List<String> tipoManutencao = [
      'Troca de Peça',
      'Lavagem',
      'Motor',
      'Elétrica',
      'Freios',
      'Luzes',
      'Pneu',
      'Revisão'
    ];

    SolicitacaoManutencaoBloc blocSolicitacaoManutencao =
        BlocProvider.of<SolicitacaoManutencaoBloc>(context);

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
      tOficina.text = coluna.data['oficina'];
      tTipoManutencao.text = coluna.data['tipoManutencao'];
      tSituacao.text = coluna.data['situacaoSolicitacao'];
      tCustoTotal.text = coluna.data['custoTotal'].toString();
      tCustoVinculado.text = coluna.data['custoVinculado'].toString();

      blocSolicitacaoManutencao.setId(tId.text);
      blocSolicitacaoManutencao.setDetalhes(tDetalhes.text);
      blocSolicitacaoManutencao.setSolicitante(tSolicitante.text);
      blocSolicitacaoManutencao.setDataAbertura(tDataAbertura.text);
      blocSolicitacaoManutencao.setDataEfetivacao(tDataEfetivacao.text);
      blocSolicitacaoManutencao.setOficina(tOficina.text);
      blocSolicitacaoManutencao.setCustoTotal(double.parse(tCustoTotal.text));
      blocSolicitacaoManutencao.setCustoVinculado(tCustoVinculado.text);
    }

    if (codigoSolicitacao != null) {
      campoHabilitado = false;
      firestore
          .collection('solicitacaoManutencao')
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
                                                enabled: campoHabilitado,
                                                obrigaCampo: true,
                                                controller: tId,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoManutencao
                                                      .setId(tId.text);
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
                                                    'Tipo Manutenção',
                                                    true,
                                                  ),
                                                  Container(
                                                    child: DropDown(
                                                      valores: tipoManutencao,
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
                                                labelCampo: 'Detalhes',
                                                largura: 500,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tDetalhes,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoManutencao
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 14.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          2.0),
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                size: 25.0,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Container(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          2.0),
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons.cancel,
                                                                size: 25.0,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                                                    blocSolicitacaoManutencao
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
                                                  blocSolicitacaoManutencao
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
                                                  blocSolicitacaoManutencao
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
                              'Informações da Manutenção',
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
                                                labelCampo: 'Oficina',
                                                largura: 500,
                                                altura: 30,
                                                obrigaCampo: true,
                                                controller: tOficina,
                                                onChanged: (String valor) {
                                                  blocSolicitacaoManutencao
                                                      .setOficina(
                                                          tOficina.text);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Custo Total',
                                              largura: 85,
                                              altura: 30,
                                              obrigaCampo: false,
                                              controller: tCustoTotal,
                                              onChanged: (String valor) {
                                                blocSolicitacaoManutencao
                                                    .setCustoTotal(double.parse(
                                                        tCustoTotal.text));
                                              },
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
                                              onChanged: (String valor) {
                                                blocSolicitacaoManutencao
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
    bool enabled,
    Function onChanged,
    TextEditingController controller,
  }) {
    return Form(
      child: AppTextField(
        label: labelCampo,
        onChanged: onChanged,
        width: largura,
        enabled: enabled,
        heigth: altura,
        required: obrigaCampo,
        controller: controller,
      ),
    );
  }
}

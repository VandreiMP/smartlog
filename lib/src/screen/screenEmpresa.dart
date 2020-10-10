import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/empresa-bloc.dart';
import 'package:smartlogproject/src/constantes/mascaras.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'package:smartlogproject/src/util/Componentes/appTextField.dart';
import 'package:smartlogproject/src/util/Componentes/requiredLabel.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
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
      child: BlocProvider<EmpresaBloc>(
        bloc: EmpresaBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/enterprise.png",
                  nomeFormulario: "CADASTRO DE EMPRESA",
                  origem: 'EMPRESA',
                  origemDado: 'EMPRESA',
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

class CriaCardFormulario extends StatefulWidget {
  final String caminhoImagem;
  final String nomeFormulario;

  const CriaCardFormulario({this.caminhoImagem, this.nomeFormulario});

  @override
  _CriaCardFormularioState createState() => _CriaCardFormularioState();
}

class _CriaCardFormularioState extends State<CriaCardFormulario> {
  List<String> atividadeEmpresa = [
    'Comércio',
    'Indústria',
    'Agroindústria',
    'Prest. Serviço',
  ];

  List<String> matrizFilial = [
    'Matriz',
    'Filial',
  ];
  /*
    Variáveis usadas para capturar o valor dos colunas do formulário
    e salvar no banco
    */
  final tId = MaskedTextController(mask: mascaraIdentificao);
  final tRazaoSocial = TextEditingController();
  final tNomeFantasia = TextEditingController();
  final tCnpj = MaskedTextController(mask: mascaraCnpj);
  final tInscEstadual = TextEditingController();
  final tAtividadeEmpresa = TextEditingController();
  final tMatrizFilial = TextEditingController();
  final tTelefone = MaskedTextController(mask: mascaraTelefone);
  final tEmail = TextEditingController();
  final tEndereco = TextEditingController();
  final tCidade = TextEditingController();
  final tUf = TextEditingController();
  final tBairro = TextEditingController();
  final tCep = MaskedTextController(mask: mascaraCep);

  bool campoHabilitado = true;

  /*
  Variáveis de Controle para exibição das listas.
  */
  String valorSelecionadoTipoEmpresa;
  String valorSelecionadoAtivideEmpresa;
  bool consultaListaAtividadeEmpresa = true;
  bool consultaListaTipoEmpresa = true;

  bool preencheDadosIniciais = true;
  bool consultaFormulario = true;

  @override
  Widget build(BuildContext context) {
    String codigoEmpresa = ModalRoute.of(context).settings.arguments;
    EmpresaBloc blocEmpresa = BlocProvider.of<EmpresaBloc>(context);
    final Firestore firestore = Firestore.instance;

    void atualizaTipoEmpresa(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          consultaFormulario = false;
          valorSelecionadoTipoEmpresa = valor;
          blocEmpresa.setMatrizFilial(valorSelecionadoTipoEmpresa);
          consultaListaTipoEmpresa = false;
        });
      }
    }

    void atualizaAtividadeEmpresa(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          consultaFormulario = false;
          valorSelecionadoAtivideEmpresa = valor;
          blocEmpresa.setAtividadeEmpresa(valorSelecionadoAtivideEmpresa);
          consultaListaAtividadeEmpresa = false;
        });
      }
    }

    if (codigoEmpresa != null) {
      campoHabilitado = false;
    }

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */

    Future consultaDados(DocumentSnapshot coluna) async {
      if (codigoEmpresa.isNotEmpty) {
        tId.text = codigoEmpresa;
      }
      tRazaoSocial.text = coluna.data['razaoSocial'];
      tNomeFantasia.text = coluna.data['nomeFantasia'];
      tCnpj.text = coluna.data['cnpj'];
      tInscEstadual.text = coluna.data['inscEstadual'];
      tTelefone.text = coluna.data['telefone'];

      if (consultaListaAtividadeEmpresa == true) {
        tAtividadeEmpresa.text = coluna.data['atividadeEmpresa'];
        atualizaAtividadeEmpresa(tAtividadeEmpresa.text);
      }
      if (consultaListaTipoEmpresa == true) {
        tMatrizFilial.text = coluna.data['matrizFilial'];
        atualizaTipoEmpresa(tMatrizFilial.text);
      }

      tEmail.text = coluna.data['email'];
      tEndereco.text = coluna.data['endereco'];
      tCidade.text = coluna.data['cidade'];
      tUf.text = coluna.data['uf'];
      tBairro.text = coluna.data['bairro'];
      tCep.text = coluna.data['cep'];

      blocEmpresa.setId(tId.text);
      blocEmpresa.setRazaoSocial(tRazaoSocial.text);
      blocEmpresa.setNomeFantasia(tNomeFantasia.text);
      blocEmpresa.setCnpj(tCnpj.text);
      blocEmpresa.setInscEstadual(tInscEstadual.text);
      blocEmpresa.setTelefone(tTelefone.text);
      blocEmpresa.setEmail(tEmail.text);
      blocEmpresa.setEndereco(tEndereco.text);
      blocEmpresa.setCidade(tCidade.text);
      blocEmpresa.setBairro(tBairro.text);
      blocEmpresa.setUf(tUf.text);
      blocEmpresa.setCep(tCep.text);
    }

    if (codigoEmpresa != null && consultaFormulario) {
      firestore
          .collection("empresa")
          .document(codigoEmpresa)
          .get()
          .then((coluna) async => await consultaDados(coluna));
    }

    return StreamBuilder<Object>(
        stream: blocEmpresa.outId,
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
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                                labelCampo: 'Identificação',
                                                largura: 150,
                                                enabled: campoHabilitado,
                                                altura: 30,
                                                controller: tId,
                                                onChanged:
                                                    (String valor) async {
                                                  blocEmpresa.setId(tId.text);
                                                },
                                                obrigaCampo: true),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: constroiCampo(
                                                labelCampo: 'Razão Social',
                                                largura: 500,
                                                altura: 30,
                                                controller: tRazaoSocial,
                                                onChanged: (String valor) {
                                                  blocEmpresa.setRazaoSocial(
                                                      tRazaoSocial.text);
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
                                              labelCampo: 'Nome Fantasia',
                                              largura: 500,
                                              altura: 30,
                                              controller: tNomeFantasia,
                                              onChanged: (String valor) {
                                                blocEmpresa.setNomeFantasia(
                                                    tNomeFantasia.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  // blocEmpresa.verificaEmpresa(
                                                  //     tId.text, context);
                                                  if (codigoEmpresa == null) {
                                                    alert(
                                                        context,
                                                        mensagemAlerta,
                                                        'Para abrir as informações do responsável, é necessário salvar os dados do formulario!');
                                                  } else {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      '/FormularioEmpresaDetalhes',
                                                      arguments: codigoEmpresa,
                                                    );
                                                  }
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
                                          children: [
                                            constroiCampo(
                                              labelCampo: 'CNPJ',
                                              largura: 150,
                                              altura: 30,
                                              obrigaCampo: true,
                                              controller: tCnpj,
                                              onChanged: (String valor) {
                                                blocEmpresa.setCnpj(tCnpj.text);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: constroiCampo(
                                                labelCampo: 'Insc. Estadual',
                                                largura: 150,
                                                altura: 30,
                                                controller: tInscEstadual,
                                                onChanged: (String valor) {
                                                  blocEmpresa.setInscEstadual(
                                                      tInscEstadual.text);
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
                                                    'Atividade',
                                                    true,
                                                  ),
                                                  Container(
                                                    height: 50.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        DropdownButton<String>(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cardo',
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.black),
                                                          items:
                                                              atividadeEmpresa
                                                                  .map((
                                                            String
                                                                dropDownStringItem,
                                                          ) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  dropDownStringItem,
                                                              child: Text(
                                                                  dropDownStringItem),
                                                            );
                                                          }).toList(),
                                                          onChanged: (novoValorSelecionado) =>
                                                              atualizaAtividadeEmpresa(
                                                                  novoValorSelecionado),
                                                          value:
                                                              valorSelecionadoAtivideEmpresa,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
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
                                                    'Tipo',
                                                    true,
                                                  ),
                                                  Container(
                                                    height: 50.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        DropdownButton<String>(
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cardo',
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.black),
                                                          items:
                                                              matrizFilial.map((
                                                            String
                                                                dropDownStringItem,
                                                          ) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  dropDownStringItem,
                                                              child: Text(
                                                                  dropDownStringItem),
                                                            );
                                                          }).toList(),
                                                          onChanged: (novoValorSelecionado) =>
                                                              atualizaTipoEmpresa(
                                                                  novoValorSelecionado),
                                                          value:
                                                              valorSelecionadoTipoEmpresa,
                                                        ),
                                                      ],
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
                                          children: [
                                            constroiCampo(
                                              labelCampo: 'Telefone',
                                              largura: 110,
                                              altura: 30,
                                              obrigaCampo: false,
                                              controller: tTelefone,
                                              onChanged: (String valor) {
                                                blocEmpresa.setTelefone(
                                                    tTelefone.text);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: constroiCampo(
                                                labelCampo: 'E-Mail',
                                                largura: 300,
                                                altura: 30,
                                                controller: tEmail,
                                                onChanged: (String valor) {
                                                  blocEmpresa
                                                      .setEmail(tEmail.text);
                                                },
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
                                          children: [
                                            constroiCampo(
                                              labelCampo: 'Endereço',
                                              largura: 300,
                                              altura: 30,
                                              controller: tEndereco,
                                              onChanged: (String valor) {
                                                blocEmpresa.setEndereco(
                                                    tEndereco.text);
                                              },
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: constroiCampo(
                                                labelCampo: 'Cidade',
                                                largura: 200,
                                                altura: 30,
                                                controller: tCidade,
                                                onChanged: (String valor) {
                                                  blocEmpresa
                                                      .setCidade(tCidade.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: constroiCampo(
                                                labelCampo: 'UF',
                                                largura: 30,
                                                altura: 30,
                                                controller: tUf,
                                                onChanged: (String valor) {
                                                  blocEmpresa.setUf(tUf.text);
                                                },
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
                                              controller: tBairro,
                                              onChanged: (String valor) {
                                                blocEmpresa
                                                    .setBairro(tBairro.text);
                                              },
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: constroiCampo(
                                                labelCampo: 'CEP',
                                                largura: 85,
                                                altura: 30,
                                                obrigaCampo: false,
                                                controller: tCep,
                                                onChanged: (String valor) {
                                                  blocEmpresa.setCep(tCep.text);
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
                            height: 10.0,
                          ),
                          Container(
                            child: AppText(
                              '*Os colunas marcados com o asterisco são obrigatórios.',
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

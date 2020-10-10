import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'package:smartlogproject/src/util/Componentes/requiredLabel.dart';
import '../constantes/mascaras.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import 'screenPattern.dart';

class ScreenUser extends StatelessWidget {
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Body(ModalRoute.of(context).settings.arguments),
    );
  }
}

class Body extends StatelessWidget {
  const Body(this.argument);

  final String argument;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4.0, left: 4.0),
      child: BlocProvider<UsuarioBloc>(
        bloc: UsuarioBloc(context),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CriaCardAuxiliar(
                  caminhoImagem: "Images/user_logo.png",
                  nomeFormulario: "CADASTRO DE USUÁRIOS",
                  origem: 'USUARIO',
                  origemDado: 'USUARIO',
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

class CriaCardFormulario extends StatefulWidget {
  @override
  _CriaCardFormularioState createState() => _CriaCardFormularioState();
}

class _CriaCardFormularioState extends State<CriaCardFormulario> {
  List<String> usuarios = [
    'Funcionário',
    'Diretor',
    'Motorista',
  ];

  final tNome = TextEditingController();
  final tId = MaskedTextController(mask: mascaraIdentificao);
  final tTpUsuario = TextEditingController();
  final tEmailLogin = TextEditingController();
  final tSenha = TextEditingController();
  final tEmail = TextEditingController();
  final tTelefone = MaskedTextController(mask: mascaraTelefone);
  final tCelular = MaskedTextController(mask: mascaraCelular);
  final tRamal = TextEditingController();

  /*
  Variáveis de Controle para exibição das listas.
  */
  String valorSelecionadoTipoUsuario;
  bool consultaListaTipoUsuario = true;

  bool editaCredenciais = true;
  bool consultaFormulario = true;
  bool campoHabilitado = true;

  @override
  Widget build(BuildContext context) {
    UsuarioBloc blocFuncionario = BlocProvider.of<UsuarioBloc>(context);

    final Firestore firestore = Firestore.instance;
    String idFuncionario = ModalRoute.of(context).settings.arguments;

    void atualizaTipoUsuario(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
          consultaFormulario = false;
          valorSelecionadoTipoUsuario = valor;
          blocFuncionario.setTpUsuario(valorSelecionadoTipoUsuario);
          consultaListaTipoUsuario = false;
        });
      }
    }

    Future consultaValor(DocumentSnapshot coluna) async {
      if (idFuncionario.isNotEmpty) {
        tId.text = idFuncionario;
      }
      tNome.text = coluna.data['nome'];
      tEmailLogin.text = coluna.data['emailLogin'];
      tSenha.text = coluna.data['senha'];
      tEmail.text = coluna.data['email'];
      tTelefone.text = coluna.data['telefone'];
      tCelular.text = coluna.data['celular'];
      tRamal.text = coluna.data['ramal'];

      if (consultaListaTipoUsuario == true) {
        tTpUsuario.text = coluna.data['tipoUsuario'];
        atualizaTipoUsuario(tTpUsuario.text);
      }

      blocFuncionario.setId(tId.text);
      blocFuncionario.setNome(tNome.text);
      blocFuncionario.setEmailLogin(tEmailLogin.text);
      blocFuncionario.setSenha(tSenha.text);
      blocFuncionario.setEmail(tEmail.text);
      blocFuncionario.setTelefone(tTelefone.text);
      blocFuncionario.setCelular(tCelular.text);
      blocFuncionario.setRamal(tRamal.text);
    }

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */
    if (idFuncionario != null && consultaFormulario) {
      campoHabilitado = false;
      firestore
          .collection("usuario")
          .document(idFuncionario)
          .get()
          .then((coluna) async => consultaValor(coluna));
    }

    //editaCredenciais =  campoHabilitado;

    return StreamBuilder<Object>(
        stream: blocFuncionario.outId,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                              'Informações de Identificação',
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
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
                                          child: constroiCampo(
                                            labelCampo: 'Nome',
                                            largura: 500,
                                            altura: 30,
                                            contextoAplicacao: context,
                                            obrigaCampo: true,
                                            controller: tNome,
                                            onChanged: (String valor) {
                                              blocFuncionario
                                                  .setNome(tNome.text);
                                            },
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
                                                enabled: campoHabilitado,
                                                obrigaCampo: true,
                                                contextoAplicacao: context,
                                                controller: tId,
                                                onChanged: (String valor) {
                                                  blocFuncionario
                                                      .setId(tId.text);
                                                },
                                                mascara:
                                                    new MaskedTextController(
                                                  mask: mascaraIdentificao,
                                                ),
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
                                                    'Tipo Usuário',
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
                                                          items: usuarios.map((
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
                                                              atualizaTipoUsuario(
                                                                  novoValorSelecionado),
                                                          value:
                                                              valorSelecionadoTipoUsuario,
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
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              child: constroiCampo(
                                                labelCampo: 'E-Mail Acesso',
                                                contextoAplicacao: context,
                                                largura: 350,
                                                altura: 30,
                                                obrigaCampo: true,
                                                enabled: editaCredenciais,
                                                controller: tEmailLogin,
                                                onChanged: (String valor) {
                                                  blocFuncionario.setEmailLogin(
                                                      tEmailLogin.text);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: constroiCampo(
                                                  labelCampo: 'Senha',
                                                  largura: 150,
                                                  altura: 30,
                                                  contextoAplicacao: context,
                                                  obrigaCampo: true,
                                                  enabled: editaCredenciais,
                                                  controller: tSenha,
                                                  onChanged: (String valor) {
                                                    blocFuncionario
                                                        .setSenha(tSenha.text);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                      onTap: () async {
                                                        if (editaCredenciais) {
                                                          if (idFuncionario ==
                                                              null) {
                                                            alert(
                                                                context,
                                                                mensagemAlerta,
                                                                'Para realizar esta operação é necessário salvar o usuário no sistema!');
                                                          } else {
                                                            blocFuncionario
                                                                .criaAlteraUsuario(
                                                                    context,
                                                                    tEmailLogin
                                                                        .text,
                                                                    tSenha.text,
                                                                    'INSERIR')
                                                                .then((retornoBloc) =>
                                                                    retornoBloc ==
                                                                            true
                                                                        ? editaCredenciais =
                                                                            false
                                                                        : editaCredenciais =
                                                                            true);
                                                          }
                                                        } else {
                                                          alert(
                                                              context,
                                                              mensagemAlerta,
                                                              'Para alterar o usuário e a senha de acesso, favor entrar em contato com o administrador do sistema!');
                                                        }
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
                                                          Icons.person_add,
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
                              'Informações para Contato',
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
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
                                          child: constroiCampo(
                                            labelCampo: 'E-Mail Alternativo',
                                            largura: 500,
                                            altura: 30,
                                            contextoAplicacao: context,
                                            obrigaCampo: false,
                                            controller: tEmail,
                                            onChanged: (String valor) {
                                              blocFuncionario
                                                  .setEmail(tEmail.text);
                                            },
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              child: constroiCampo(
                                                labelCampo: 'Telefone',
                                                largura: 110,
                                                altura: 30,
                                                contextoAplicacao: context,
                                                obrigaCampo: false,
                                                controller: tTelefone,
                                                onChanged: (String valor) {
                                                  blocFuncionario.setTelefone(
                                                      tTelefone.text);
                                                },
                                                mascara:
                                                    new MaskedTextController(
                                                  mask: mascaraTelefone,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Container(
                                                child: constroiCampo(
                                                  labelCampo: 'Celular',
                                                  largura: 112,
                                                  altura: 30,
                                                  contextoAplicacao: context,
                                                  obrigaCampo: false,
                                                  controller: tCelular,
                                                  onChanged: (String valor) {
                                                    blocFuncionario.setCelular(
                                                        tCelular.text);
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Container(
                                                child: constroiCampo(
                                                  labelCampo: 'Ramal',
                                                  largura: 112,
                                                  altura: 30,
                                                  contextoAplicacao: context,
                                                  obrigaCampo: false,
                                                  controller: tRamal,
                                                  onChanged: (String valor) {
                                                    blocFuncionario
                                                        .setRamal(tRamal.text);
                                                  },
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
              //   );
              // }),
            ),
          );
        });
  }

  Widget constroiCampo({
    String labelCampo,
    Function onChanged,
    double largura,
    double altura,
    bool enabled,
    bool obrigaCampo,
    BuildContext contextoAplicacao,
    TextEditingController mascara,
    TextEditingController controller,
    String valorInicial,
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
              cursorColor: Colors.black,
              enabled: enabled,
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontFamily: 'Cardo',
                fontSize: 17,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(1, 0, 2, 10),
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

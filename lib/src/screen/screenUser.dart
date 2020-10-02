import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/Entidades/classes/usuario.dart';
import '../constantes/mascaras.dart';
import '../funcoes/appText.dart';
import '../Cards/Widgets/criaCardAuxiliar.dart';
import '../funcoes/criaLista.dart';
import '../funcoes/requiredLabel.dart';
import 'screenPattern.dart';

// class ScreenArguments {
//   final String identificacao;

//   ScreenArguments(this.identificacao);
// }

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
                  nomeFormulario: "Cadastro de Usuários",
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

  final tId = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    UsuarioBloc blocFuncionario = BlocProvider.of<UsuarioBloc>(context);

    final Firestore firestore = Firestore.instance;
    String idFuncionario = ModalRoute.of(context).settings.arguments;
    bool campoHabilitado = true;
    bool escondeCampo;

    void atualizaTipoUsuario(String valor) {
      if (valor.isNotEmpty) {
        setState(() {
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
    if (idFuncionario != null) {
      campoHabilitado = false;
      firestore
          .collection("usuario")
          .document(idFuncionario)
          .get()
          .then((coluna) async => consultaValor(coluna));
    }

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
                                                          items:
                                                              usuarios
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
                                                  controller: tSenha,
                                                  onChanged: (String valor) {
                                                    blocFuncionario
                                                        .setSenha(tSenha.text);
                                                  },
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
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(),
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

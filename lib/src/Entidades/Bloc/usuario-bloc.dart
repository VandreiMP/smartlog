import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/usuario.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/alertErro.dart';
import 'package:smartlogproject/src/util/Componentes/alertFuncao.dart';

class UsuarioBloc extends BlocBase {
  BuildContext contextoAplicacao;

  UsuarioBloc(BuildContext contextoAplicacao);
  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setId(String value) => _idController.sink.add(value);
  void setNome(String value) => _nomeController.sink.add(value);
  void setTpUsuario(String value) => _tpUsuarioController.sink.add(value);
  void setSenha(String value) => _senhaController.sink.add(value);
  void setEmail(String value) => _emailController.sink.add(value);
  void setEmailLogin(String value) => _emailLoginController.sink.add(value);
  void setTelefone(String value) => _telefoneController.sink.add(value);
  void setCelular(String value) => _celularController.sink.add(value);
  void setRamal(String value) => _ramalController.sink.add(value);

  void setUsuario(Usuario usuario) {
    setNome(usuario.nome);
    setTpUsuario(usuario.tpUsuario);
    setEmailLogin(usuario.emailLogin);
    setSenha(usuario.senha);
    setEmail(usuario.email);
    setTelefone(usuario.telefone);
    setCelular(usuario.celular);
    setRamal(usuario.ramal);
  }

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idController = BehaviorSubject<String>();
  Stream<String> get outId => _idController.stream;

  var _nomeController = BehaviorSubject<String>();
  Stream<String> get outName => _nomeController.stream;

  var _tpUsuarioController = BehaviorSubject<String>();
  Stream<String> get outTpusuario => _tpUsuarioController.stream;

  var _emailController = BehaviorSubject<String>();
  Stream<String> get outEmail => _emailController.stream;

  var _emailLoginController = BehaviorSubject<String>();
  Stream<String> get outEmailLogin => _emailLoginController.stream;

  var _senhaController = BehaviorSubject<String>();
  Stream<String> get outSenha => _senhaController.stream;

  var _telefoneController = BehaviorSubject<String>();
  Stream<String> get outTelefone => _telefoneController.stream;

  var _celularController = BehaviorSubject<String>();
  Stream<String> get outCelular => _celularController.stream;

  var _ramalController = BehaviorSubject<String>();
  Stream<String> get outRamal => _ramalController.stream;

  /*
  Controller com os resultados da consulta na tabela
  */

  var _controllerFuncionario = BehaviorSubject<QuerySnapshot>();

  Stream<QuerySnapshot> get outFuncionario => _controllerFuncionario.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a identificação como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var usuario = Usuario();

    usuario.identificacao = _idController.value;
    usuario.nome = _nomeController.value;
    usuario.tpUsuario = _tpUsuarioController.value;
    usuario.email = _emailController.value;
    usuario.emailLogin = _emailLoginController.value;
    usuario.senha = _senhaController.value;
    usuario.telefone = _telefoneController.value;
    usuario.celular = _celularController.value;
    usuario.ramal = _ramalController.value;

    if (usuario.nome == '' || usuario.nome == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar o nome!');
    } else if (usuario.identificacao == '' || usuario.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar a identificação!');
    } else if (usuario.tpUsuario == '' || usuario.tpUsuario == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar o tipo!');
    } else if (usuario.emailLogin == '' || usuario.emailLogin == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar o E-Mail de acesso ao sistema!');
    } else if (usuario.senha == '' || usuario.senha == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar a senha de acesso ao sistema!');
    } else {
      try {
        await Firestore.instance
            .collection("usuario")
            .document(usuario.identificacao)
            .get()
            .then(
              (coluna) async => coluna.exists == true
                  ? alert(contextoAplicacao, mensagemAlerta,
                      'Este código de usuário já existe. Favor alterar!')
                  : Firestore.instance
                      .collection('usuario')
                      .document(usuario.identificacao)
                      .setData({
                      'identificacao': usuario.identificacao,
                      'nome': usuario.nome,
                      'tipoUsuario': usuario.tpUsuario,
                      'email': usuario.email,
                      'emailLogin': usuario.emailLogin,
                      'senha': usuario.senha,
                      'telefone': usuario.telefone,
                      'celular': usuario.celular,
                      'ramal': usuario.ramal
                    }).then(
                      (value) async => await alertFuncao(
                        contextoAplicacao,
                        mensagemNotificacao,
                        mensagemSucessoSalvar,
                        () {
                          Navigator.of(contextoAplicacao).pushNamed(
                            '/FormularioUsuario',
                            arguments: usuario.identificacao,
                          );
                        },
                      ),
                    ),
            );
      } catch (on) {
        TextError(mensagemErroSalvar);
      }
    }
  }

  /*
  Método que apaga os dados do formulário na tabela do Firebase.
  Primeiro busca a identificação informada no formulário através dos controllers,
  para depois excluir o registro na tabela do Firebase filtrando pela
  identificação, que é a PK desta tabela.
  */

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var usuario = Usuario();

    usuario.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('usuario')
          .document(usuario.identificacao)
          .delete()
          .then(
            (value) => alertFuncao(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoApagar,
                () {
              Navigator.of(contextoAplicacao).pushNamed(
                '/FormularioUsuario',
              );
            }),
          )
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      alert(contextoAplicacao, mensagemErro, mensagemErroApagar);
    }
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var usuario = Usuario();

    usuario.identificacao = _idController.value;
    usuario.nome = _nomeController.value;
    usuario.tpUsuario = _tpUsuarioController.value;
    usuario.email = _emailController.value;
    usuario.emailLogin = _emailLoginController.value;
    usuario.senha = _senhaController.value;
    usuario.telefone = _telefoneController.value;
    usuario.celular = _celularController.value;
    usuario.ramal = _ramalController.value;

    if (usuario.nome == '' || usuario.nome == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar o nome!');
    } else if (usuario.identificacao == '' || usuario.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar a identificação!');
    } else if (usuario.tpUsuario == '' || usuario.tpUsuario == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar o tipo!');
    } else if (usuario.emailLogin == '' || usuario.emailLogin == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar o E-Mail de acesso ao sistema!');
    } else if (usuario.senha == '' || usuario.senha == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o usuário é necessário informar a senha de acesso ao sistema!');
    } else {
      try {
        await Firestore.instance
            .collection('usuario')
            .document(usuario.identificacao)
            .updateData({
          'identificacao': usuario.identificacao,
          'nome': usuario.nome,
          'tipoUsuario': usuario.tpUsuario,
          'email': usuario.email,
          'emailLogin': usuario.emailLogin,
          'senha': usuario.senha,
          'telefone': usuario.telefone,
          'celular': usuario.celular,
          'ramal': usuario.ramal
        }).then((value) async => await alert(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
      } catch (on) {
        TextError(mensagemErroSalvar);
      }
    }
  }

  /*
  Método que apaga os dados do formulário na tabela do Firebase.
  Primeiro busca a identificação informada no formulário através dos controllers,
  para depois excluir o registro na tabela do Firebase filtrando pela
  identificação, que é a PK desta tabela.
  */

  Future<bool> criaAlteraUsuario(BuildContext contextoAplicacao,
      String emailAcesso, String senhaAcesso, String origem) async {
    var usuario = Usuario();
    bool criouUsuario;
    usuario.identificacao = _idController.value;
    FirebaseAuth instanciaFirebaseAuth = FirebaseAuth.instance;

    void atualizaCredenciais(
        DocumentSnapshot coluna, String emailAcesso, String senhaAcesso) {
      if (coluna.data['emailLogin'] != emailAcesso) {
        instanciaFirebaseAuth
            .currentUser()
            .then((usuario) => usuario.updateEmail(emailAcesso));
      }
      if (coluna.data['senha'] != senhaAcesso) {
        instanciaFirebaseAuth
            .currentUser()
            .then((usuario) => usuario.updatePassword(emailAcesso));
      }
    }

    if (emailAcesso == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para criar as credenciais de acesso do usuário, é necessário informar o E-Mail!');
    } else if (senhaAcesso == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para criar as credenciais de acesso do usuário, é necessário informar a senha!');
    } else {
      if (origem == 'INSERIR') {
        try {
          await Firestore.instance
              .collection('usuario')
              .document(usuario.identificacao)
              .get()
              .then((coluna) => instanciaFirebaseAuth
                      .createUserWithEmailAndPassword(
                          email: emailAcesso, password: senhaAcesso)
                      .whenComplete(() async {
                    criouUsuario = true;
                  }));
        } catch (on) {
          TextError(
              'Erro ao criar o usuário. Favor verificar se este e-mail e senha já estão em uso no sistema!');
        }
      } else if (origem == 'ATUALIZAR') {
        await Firestore.instance
            .collection('usuario')
            .document(usuario.identificacao)
            .get()
            .then((coluna) =>
                atualizaCredenciais(coluna, emailAcesso, senhaAcesso));
      } else if (origem == 'DELETAR') {
        instanciaFirebaseAuth.currentUser().then((usuario) => usuario.delete());
      }
      if (criouUsuario == true) {
        await alert(contextoAplicacao, mensagemNotificacao,
            'As credenciais de acesso ao sistema foram criadas para o usuário informado. Para realizar o acesso devem ser informados o E-Mail Acesso e a Senha na tela de Autenticação.');
      }

      return criouUsuario;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

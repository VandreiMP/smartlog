import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/usuario.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';
import 'package:smartlogproject/src/funcoes/alertFuncao.dart';

class UsuarioBloc extends BlocBase {
  String _documentId;
  String _nome;
  String _tpUsuario;
  String _senha;
  String _email;
  String _telefone;
  String _celular;
  String _ramal;
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

    /*
    Aqui realiza a validação dos campos obrigatórios.
    */

    if (usuario.nome == null) {
      TextError(
          'Para gravar o usuário no sistema, o campo "Nome" deve ser preenchido. Favor verificar!');
    }

    if (usuario.identificacao == null) {
      TextError(
          'Para gravar o usuário no sistema, o campo "Identificação" deve ser preenchido. Favor verificar!');
    }

    // if (usuario.tpUsuario == null) {
    //   alert(contextoAplicacao, 'Campo Obrigatório',
    //       'Para gravar o usuário no sistema, o campo "Tipo Usuário" deve ser preenchido. Favor verificar!');
    // }

    if (usuario.emailLogin == null) {
      TextError(
          'Para gravar o usuário no sistema, o campo "E-Mail Acesso" deve ser preenchido. Favor verificar!');
    }

    if (usuario.senha == null) {
      TextError(
          'Para gravar o usuário no sistema, o campo "Senha" deve ser preenchido. Favor verificar!');
    }

    final instanciaFirebaseAuth = FirebaseAuth.instance;

    try {
      await Firestore.instance
              .collection('usuario')
              .document(usuario.identificacao)
              .setData({
        'identificacao': usuario.identificacao,
        'nome': usuario.nome,
        // 'tipoUsuario': usuario.tpUsuario,
        'email': usuario.email,
        'emailLogin': usuario.emailLogin,
        'senha': usuario.senha,
        'telefone': usuario.telefone,
        'celular': usuario.celular,
        'ramal': usuario.ramal
      }).then((value) async => await alert(
                  contextoAplicacao,
                  'Notificação',
                  'Os dados do formulário foram salvos com sucesso no banco de dados!'))
          // .whenComplete(() async => await instanciaFirebaseAuth
          //         .createUserWithEmailAndPassword(
          //             email: usuario.emailLogin, password: usuario.senha)
          //         .whenComplete(() async {
          //       await alert(contextoAplicacao, 'Notificação de Sucesso',
          //           'As credenciais de acesso ao sistema foram criadas para o usuário informado. Para realizar o acesso devem ser informados o E-Mail Acesso e a Senha na tela de Autenticação.');
          //     }))
          ;
    } catch (on) {
      TextError('Erro ao salvar os dados do formulário no banco de dados!');
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
            (value) => alertFuncao(contextoAplicacao, 'Notificação',
                'Os dados do formulário foram apagados com sucesso no banco de dados!',
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
      alert(contextoAplicacao, 'Erro',
          'Erro ao apagar os dados do formulário no banco de dados!');
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

    try {
      await Firestore.instance
          .collection('usuario')
          .document(usuario.identificacao)
          .updateData({
        'identificacao': usuario.identificacao,
        'nome': usuario.nome,
        // 'tipoUsuario': usuario.tpUsuario,
        'email': usuario.email,
        'emailLogin': usuario.emailLogin,
        'senha': usuario.senha,
        'telefone': usuario.telefone,
        'celular': usuario.celular,
        'ramal': usuario.ramal
      }).then((value) async => await alert(
              contextoAplicacao,
              'Notificação',
              'Os dados do formulário foram atualizados com sucesso no banco de dados!'));
    } catch (on) {
      TextError('Erro ao atualizar os dados do formulário no banco de dados!');
    }
  }

  @override
  void dispose() {}
}

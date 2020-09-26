import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/custo.dart';
import 'package:smartlogproject/src/Entidades/classes/embalagem.dart';
import 'package:smartlogproject/src/Entidades/classes/empresa.dart';
import 'package:smartlogproject/src/Entidades/classes/responsavelEmpresa.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';
import 'package:smartlogproject/src/funcoes/alertFuncao.dart';

class ResponsavelEmpresaBloc extends BlocBase {
  String _identificacaoResponsavelEmpresa;
  String _nome;
  String _rg;
  String _cpf;
  String _cargo;
  String _email;

  BuildContext contextoAplicacao;

  ResponsavelEmpresaBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setIdentificacaoResponsavelEmpresa(String value) =>
      _idResponsavelEmpresaController.sink.add(value);
  void setNome(String value) => _nomeController.sink.add(value);
  void setRg(String value) => _rgController.sink.add(value);
  void setCpf(String value) => _cpfController.sink.add(value);
  void setCargo(String value) => _cargoController.sink.add(value);
  void setEmail(String value) => _emailController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idResponsavelEmpresaController = BehaviorSubject<String>();
  Stream<String> get outIdResponsavelEmpresa =>
      _idResponsavelEmpresaController.stream;

  var _nomeController = BehaviorSubject<String>();
  Stream<String> get outNome => _nomeController.stream;

  var _rgController = BehaviorSubject<String>();
  Stream<String> get outRg => _rgController.stream;

  var _cpfController = BehaviorSubject<String>();
  Stream<String> get outCpf => _cpfController.stream;

  var _cargoController = BehaviorSubject<String>();
  Stream<String> get outCargo => _cargoController.stream;

  var _emailController = BehaviorSubject<String>();
  Stream<String> get outEmail => _emailController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a identificação como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var responsavelEmpresa = ResponsavelEmpresa();

    responsavelEmpresa.identificacaoEmpresa =
        _idResponsavelEmpresaController.value;
    responsavelEmpresa.nome = _nomeController.value;
    responsavelEmpresa.rg = _rgController.value;
    responsavelEmpresa.cpf = _cpfController.value;
    responsavelEmpresa.cargo = _cargoController.value;
    responsavelEmpresa.email = _emailController.value;
    print(responsavelEmpresa.identificacaoEmpresa);
    await Firestore.instance
        .collection('responsavelEmpresa')
        .document(responsavelEmpresa.identificacaoEmpresa)
        .setData({
      'identificacaoEmpresa': responsavelEmpresa.identificacaoEmpresa,
      'nome': responsavelEmpresa.nome,
      'rg': responsavelEmpresa.rg,
      'cpf': responsavelEmpresa.cpf,
      'cargo': responsavelEmpresa.cargo,
      'email': responsavelEmpresa.email,
    }).then((value) async => await alert(
            contextoAplicacao,
            'Notificação de Sucesso',
            'Os dados do formulário foram salvos com sucesso no banco de dados!'));
  }

  /*
  Método que apaga os dados do formulário na tabela do Firebase.
  Primeiro busca a identificação informada no formulário através dos controllers,
  para depois excluir o registro na tabela do Firebase filtrando pela
  identificação, que é a PK desta tabela.
  */

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var responsavelEmpresa = ResponsavelEmpresa();

    responsavelEmpresa.identificacaoEmpresa =
        _idResponsavelEmpresaController.value;

    try {
      await Firestore.instance
          .collection('responsavelEmpresa')
          .document(responsavelEmpresa.identificacaoEmpresa)
          .delete()
          .then(
            (value) => Navigator.of(contextoAplicacao).pushNamed(
              '/FormularioEmpresaDetalhes',
              arguments: _idResponsavelEmpresaController.value,
            ),
          )
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError('Erro ao apagar os dados do formulário no banco de dados!');
    }
  }

  Future<void> atualizaDados(
      BuildContext contextoAplicacao, String chaveConsulta) async {
    var responsavelEmpresa = ResponsavelEmpresa();

    responsavelEmpresa.identificacaoEmpresa =
        _idResponsavelEmpresaController.value;
    responsavelEmpresa.nome = _nomeController.value;
    responsavelEmpresa.rg = _rgController.value;
    responsavelEmpresa.cpf = _cpfController.value;
    responsavelEmpresa.cargo = _cargoController.value;
    responsavelEmpresa.email = _emailController.value;

    try {
      await Firestore.instance
          .collection('responsavelEmpresa')
          .document(chaveConsulta)
          .updateData({
        'identificacaoEmpresa': responsavelEmpresa.identificacaoEmpresa,
        'nome': responsavelEmpresa.nome,
        'rg': responsavelEmpresa.rg,
        'cpf': responsavelEmpresa.cpf,
        'cargo': responsavelEmpresa.cargo,
        'email': responsavelEmpresa.email,
      }).then((value) async => await alert(
              contextoAplicacao,
              'Notificação de Sucesso',
              'Os dados do formulário foram atualizados com sucesso no banco de dados!'));
    } catch (on) {
      TextError('Erro ao atualizar os dados do formulário no banco de dados!');
    }
  }

  @override
  void dispose() {}
}

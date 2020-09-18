import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/custo.dart';
import 'package:smartlogproject/src/Entidades/classes/embalagem.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';

class CustoBloc extends BlocBase {
  String _documentId;
  String _detalhes;
  String _modalidade;
  String _periodicidade;
  String _analiseGerencial;
  String _valor;

  BuildContext contextoAplicacao;

  CustoBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setId(String value) => _idController.sink.add(value);
  void setDetalhes(String value) => _detalhesController.sink.add(value);
  void setModalidade(String value) => _modalidadeController.sink.add(value);
  void setPeriodicidade(String value) =>
      _periodicidadeController.sink.add(value);
  void setAnaliseGerencial(String value) =>
      _analiseGerencialController.sink.add(value);
  void setValor(String value) => _valorController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idController = BehaviorSubject<String>();
  Stream<String> get outId => _idController.stream;

  var _detalhesController = BehaviorSubject<String>();
  Stream<String> get outDetalhes => _detalhesController.stream;

  var _modalidadeController = BehaviorSubject<String>();
  Stream<String> get outModalidade => _modalidadeController.stream;

  var _periodicidadeController = BehaviorSubject<String>();
  Stream<String> get outPeriodicidade => _periodicidadeController.stream;

  var _analiseGerencialController = BehaviorSubject<String>();
  Stream<String> get outAnaliseGerencial => _analiseGerencialController.stream;

  var _valorController = BehaviorSubject<String>();
  Stream<String> get outValor => _valorController.stream;

  var _custoController = BehaviorSubject<QuerySnapshot>();
  Stream<QuerySnapshot> get outCustos => _custoController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a identificação como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var custo = Custo();

    custo.identificacao = _idController.value;
    custo.detalhes = _detalhesController.value;
    custo.modalidade = _modalidadeController.value;
    custo.periodicidade = _periodicidadeController.value;
    custo.analiseGerencial = _analiseGerencialController.value;
    custo.valor = _valorController.value;

    try {
      await Firestore.instance
          .collection('custos')
          .document(custo.identificacao)
          .setData({
        'identificacao': custo.identificacao,
        'detalhes': custo.detalhes,
        'modalidade': custo.modalidade,
        'periodicidade': custo.periodicidade,
        'analiseGerencial': custo.analiseGerencial,
        'valor': custo.valor,
      }).then((value) async => await alert(
              contextoAplicacao,
              'Notificação de Sucesso',
              'Os dados do formulário foram salvos com sucesso no banco de dados!'));
    } catch (on) {
      TextError('Erro ao salvar os dados do formulário no banco de dados!');
    }
  }

  /*
  Método que consulta os dados do formulário na tabela do Firebase.
  */

  String consultarDados(BuildContext contextoAplicacao, String identificacao) {
    var custo = Custo();
    final valor = TextEditingController();
    final Firestore firestore = Firestore.instance;
    void consultaValor(DocumentSnapshot campo) {
      valor.text = campo.data['detalhes'];
    }

    Future<dynamic> consultaDetalhes = firestore
        .collection("custos")
        .document('1')
        .get()
        .then((value) => consultaValor(value));

    return valor.text;
  }

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var custo = Custo();

    custo.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('custos')
          .document(custo.identificacao)
          .delete()
          .then(
            (value) => alert(contextoAplicacao, 'Notificação de Sucesso',
                'Os dados do formulário foram apagados com sucesso no banco de dados!'),
          )
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError('Erro ao apagar os dados do formulário no banco de dados!');
    }
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var custo = Custo();

    custo.identificacao = _idController.value;
    custo.detalhes = _detalhesController.value;
    custo.modalidade = _modalidadeController.value;
    custo.periodicidade = _periodicidadeController.value;
    custo.analiseGerencial = _analiseGerencialController.value;
    custo.valor = _valorController.value;

    try {
      await Firestore.instance
          .collection('custos')
          .document(custo.identificacao)
          .updateData({
        'identificacao': custo.identificacao,
        'detalhes': custo.detalhes,
        'modalidade': custo.modalidade,
        'periodicidade': custo.periodicidade,
        'analiseGerencial': custo.analiseGerencial,
        'valor': custo.valor,
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

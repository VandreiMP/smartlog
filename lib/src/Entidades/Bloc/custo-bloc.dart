import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/custo.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/alertErro.dart';
import 'package:smartlogproject/src/util/Componentes/alertFuncao.dart';

class CustoBloc extends BlocBase {
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
  void setValor(double value) => _valorController.sink.add(value);

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

  var _valorController = BehaviorSubject<double>();
  Stream<double> get outValor => _valorController.stream;

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

    if (custo.identificacao == '' || custo.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar a identificação!');
    } else if (custo.detalhes == '' || custo.detalhes == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar os detalhes!');
    } else if (custo.modalidade == '' || custo.modalidade == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar a modalidade!');
    } else if (custo.periodicidade == '' || custo.periodicidade == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar a periodicidade!');
    } else if (custo.analiseGerencial == '' || custo.analiseGerencial == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar se o mesmo é considerado na análise gerencial!');
    } else if (custo.modalidade == 'Fixo' &&
        (custo.valor == null || custo.valor == 0)) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar se o mesmo é considerado na análise gerencial!');
    } else {
      try {
        await Firestore.instance
            .collection("custos")
            .document(custo.identificacao)
            .get()
            .then(
              (coluna) async => coluna.exists == true
                  ? alert(contextoAplicacao, mensagemAlerta,
                      'Este código de custo já existe. Favor alterar!')
                  : await Firestore.instance
                      .collection('custos')
                      .document(custo.identificacao)
                      .setData({
                      'identificacao': custo.identificacao,
                      'detalhes': custo.detalhes,
                      'modalidade': custo.modalidade,
                      'periodicidade': custo.periodicidade,
                      'analiseGerencial': custo.analiseGerencial,
                      'valor': custo.valor,
                    }).then(
                      (value) async => await alertFuncao(
                        contextoAplicacao,
                        mensagemNotificacao,
                        mensagemSucessoSalvar,
                        () {
                          Navigator.of(contextoAplicacao).pushNamed(
                              '/FormularioCustos',
                              arguments: custo.identificacao);
                        },
                      ),
                    ),
            );
      } catch (on) {
        TextError(mensagemErroSalvar);
      }
    }
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
            (value) => alertFuncao(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoApagar,
                () {
              Navigator.of(contextoAplicacao).pushNamed(
                '/FormularioCustos',
              );
            }),
          )
          .catchError((ErrorAndStacktrace erro) {});
    } catch (on) {
      TextError(mensagemErroApagar);
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

    if (custo.identificacao == '' || custo.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar a identificação!');
    } else if (custo.detalhes == '' || custo.detalhes == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar os detalhes!');
    } else if (custo.modalidade == '' || custo.modalidade == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar a modalidade!');
    } else if (custo.periodicidade == '' || custo.periodicidade == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar a periodicidade!');
    } else if (custo.analiseGerencial == '' || custo.analiseGerencial == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar se o mesmo é considerado na análise gerencial!');
    } else if (custo.modalidade == 'Fixo' &&
        (custo.valor == null || custo.valor == 0)) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o custo é necessário informar se o mesmo é considerado na análise gerencial!');
    } else {
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
                contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
      } catch (on) {
        TextError(mensagemErroSalvar);
      }
    }
  }

  @override
  void dispose() {}
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/solicitacaoManutencao.dart';
import 'package:smartlogproject/src/Entidades/classes/embalagem.dart';
import 'package:smartlogproject/src/Entidades/classes/solicitacaoManutencao.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';
import 'package:smartlogproject/src/funcoes/calculaCustoSolicitacao.dart';

class SolicitacaoManutencaoBloc extends BlocBase {
  String _identificacao;
  String _tipoManutencao;
  String _detalhes;
  String _situacaoSolicitacao;
  String _solicitante;
  String _dataAbertura;
  String _dataEfetivacao;
  String _oficina;
  String _fornecedor;
  double _precoLitro;
  double _quantidade;
  double _custoTotal;
  String _custoVinculado;

  BuildContext contextoAplicacao;

  SolicitacaoManutencaoBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setId(String value) => _idController.sink.add(value);
  void setTipoManutencao(String value) =>
      _tipoManutencaoController.sink.add(value);
  void setDetalhes(String value) => _detalhesController.sink.add(value);
  void setSituacaoSolicitacao(String value) =>
      _situacaoSolicitacaoController.sink.add(value);
  void setSolicitante(String value) => _solicitanteController.sink.add(value);
  void setDataAbertura(String value) => _dataAberturaController.sink.add(value);
  void setDataEfetivacao(String value) =>
      _dataEfetivacaoController.sink.add(value);
  void setOficina(String value) => _oficinaController.sink.add(value);
  void setCustoTotal(double value) => _custoTotalController.sink.add(value);
  void setCustoVinculado(String value) =>
      _custoVinculadoController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idController = BehaviorSubject<String>();
  Stream<String> get outId => _idController.stream;

  var _tipoManutencaoController = BehaviorSubject<String>();
  Stream<String> get outTipoManutencao => _tipoManutencaoController.stream;

  var _detalhesController = BehaviorSubject<String>();
  Stream<String> get outDetalhes => _detalhesController.stream;

  var _situacaoSolicitacaoController = BehaviorSubject<String>();
  Stream<String> get outSituacaoSolicitacao =>
      _situacaoSolicitacaoController.stream;

  var _solicitanteController = BehaviorSubject<String>();
  Stream<String> get outSolicitante => _solicitanteController.stream;

  var _dataAberturaController = BehaviorSubject<String>();
  Stream<String> get outDataAbertura => _dataAberturaController.stream;

  var _dataEfetivacaoController = BehaviorSubject<String>();
  Stream<String> get outDataEfetivacao => _dataEfetivacaoController.stream;

  var _oficinaController = BehaviorSubject<String>();
  Stream<String> get outOficina => _oficinaController.stream;

  var _custoTotalController = BehaviorSubject<double>();
  Stream<double> get outCustoTotal => _custoTotalController.stream;

  var _custoVinculadoController = BehaviorSubject<String>();
  Stream<String> get outCustoVinculado => _custoVinculadoController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a carga como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var solicitacaoManutencao = SolicitacaoManutencao();

    solicitacaoManutencao.identificacao = _idController.value;
    solicitacaoManutencao.tipoManutencao = _tipoManutencaoController.value;
    solicitacaoManutencao.detalhes = _detalhesController.value;
    solicitacaoManutencao.situacaoSolicitacao =
        _situacaoSolicitacaoController.value;
    solicitacaoManutencao.solicitante = _solicitanteController.value;
    solicitacaoManutencao.dataAbertura = _dataAberturaController.value;
    solicitacaoManutencao.dataEfetivacao = _dataEfetivacaoController.value;
    solicitacaoManutencao.oficina = _oficinaController.value;
    solicitacaoManutencao.custoTotal = _custoTotalController.value;
    solicitacaoManutencao.custoVinculado = _custoVinculadoController.value;

    try {
      await Firestore.instance
          .collection('solicitacaoManutencao')
          .document(solicitacaoManutencao.identificacao)
          .setData({
        'identificacao': solicitacaoManutencao.identificacao,
        'tipoManutencao': solicitacaoManutencao.tipoManutencao,
        'detalhes': solicitacaoManutencao.detalhes,
        'situacaoSolicitacao': solicitacaoManutencao.situacaoSolicitacao,
        'solicitante': solicitacaoManutencao.solicitante,
        'dataAbertura': solicitacaoManutencao.dataAbertura,
        'dataEfetivacao': solicitacaoManutencao.dataEfetivacao,
        'oficina': solicitacaoManutencao.oficina,
        'custoTotal': solicitacaoManutencao.custoTotal,
        'custoVinculado': solicitacaoManutencao.custoVinculado
      }).then((value) async => await alert(
              contextoAplicacao,
              'Notificação de Sucesso',
              'Os dados do formulário foram salvos com sucesso no banco de dados!'));
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
    var solicitacaoManutencao = SolicitacaoManutencao();

    solicitacaoManutencao.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('solicitacaoManutencao')
          .document(solicitacaoManutencao.identificacao)
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
    var solicitacaoManutencao = SolicitacaoManutencao();

    solicitacaoManutencao.identificacao = _idController.value;
    solicitacaoManutencao.tipoManutencao = _tipoManutencaoController.value;
    solicitacaoManutencao.detalhes = _detalhesController.value;
    solicitacaoManutencao.situacaoSolicitacao =
        _situacaoSolicitacaoController.value;
    solicitacaoManutencao.solicitante = _solicitanteController.value;
    solicitacaoManutencao.dataAbertura = _dataAberturaController.value;
    solicitacaoManutencao.dataEfetivacao = _dataEfetivacaoController.value;
    solicitacaoManutencao.oficina = _oficinaController.value;
    solicitacaoManutencao.custoTotal = _custoTotalController.value;
    solicitacaoManutencao.custoVinculado = _custoVinculadoController.value;

    try {
      await Firestore.instance
          .collection('solicitacaoManutencao')
          .document(solicitacaoManutencao.identificacao)
          .updateData({
        'identificacao': solicitacaoManutencao.identificacao,
        'tipoManutencao': solicitacaoManutencao.tipoManutencao,
        'detalhes': solicitacaoManutencao.detalhes,
        'situacaoSolicitacao': solicitacaoManutencao.situacaoSolicitacao,
        'solicitante': solicitacaoManutencao.solicitante,
        'dataAbertura': solicitacaoManutencao.dataAbertura,
        'dataEfetivacao': solicitacaoManutencao.dataEfetivacao,
        'oficina': solicitacaoManutencao.oficina,
        'custoTotal': solicitacaoManutencao.custoTotal,
        'custoVinculado': solicitacaoManutencao.custoVinculado
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
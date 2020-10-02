import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/solicitacaoAbastecimento.dart';
import 'package:smartlogproject/src/Entidades/classes/embalagem.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';
import 'package:smartlogproject/src/funcoes/alertFuncao.dart';
import 'package:smartlogproject/src/funcoes/calculaCustoSolicitacao.dart';

class SolicitacaoAbastecimentoBloc extends BlocBase {
  String _identificacao;
  String _detalhes;
  String _situacaoSolicitacao;
  String _solicitante;
  String _dataAbertura;
  String _dataEfetivacao;
  String _posto;
  String _tipoCombustivel;
  double _precoLitro;
  double _quantidade;
  double _custoTotal;
  String _custoVinculado;

  BuildContext contextoAplicacao;

  SolicitacaoAbastecimentoBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setId(String value) => _idController.sink.add(value);
  void setDetalhes(String value) => _detalhesController.sink.add(value);
  void setSituacaoSolicitacao(String value) =>
      _situacaoSolicitacaoController.sink.add(value);
  void setSolicitante(String value) => _solicitanteController.sink.add(value);
  void setDataAbertura(String value) => _dataAberturaController.sink.add(value);
  void setDataEfetivacao(String value) =>
      _dataEfetivacaoController.sink.add(value);
  void setPosto(String value) => _postoController.sink.add(value);
  void setCombustivel(String value) =>
      _tipoCombustivelController.sink.add(value);
  void setPrecoLitro(double value) => _precoLitroController.sink.add(value);
  void setQuantidade(double value) => _quantidadeController.sink.add(value);
  void setCustoTotal(double value) => _custoTotalController.sink.add(value);
  void setCustoVinculado(String value) =>
      _custoVinculadoController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idController = BehaviorSubject<String>();
  Stream<String> get outId => _idController.stream;

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

  var _postoController = BehaviorSubject<String>();
  Stream<String> get outPosto => _postoController.stream;

  var _tipoCombustivelController = BehaviorSubject<String>();
  Stream<String> get outTipoCombustivel => _tipoCombustivelController.stream;

  var _precoLitroController = BehaviorSubject<double>();
  Stream<double> get outPrecoLitro => _precoLitroController.stream;

  var _quantidadeController = BehaviorSubject<double>();
  Stream<double> get outQuantidade => _quantidadeController.stream;

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
    var solicitacaoAbastecimento = SolicitacaoAbastecimento();

    solicitacaoAbastecimento.identificacao = _idController.value;
    solicitacaoAbastecimento.detalhes = _detalhesController.value;
    solicitacaoAbastecimento.situacaoSolicitacao =
        _situacaoSolicitacaoController.value;
    solicitacaoAbastecimento.solicitante = _solicitanteController.value;
    solicitacaoAbastecimento.dataAbertura = _dataAberturaController.value;
    solicitacaoAbastecimento.dataEfetivacao = _dataEfetivacaoController.value;
    solicitacaoAbastecimento.posto = _postoController.value;
    solicitacaoAbastecimento.tipoCombustivel = _tipoCombustivelController.value;
    solicitacaoAbastecimento.precoLitro = _precoLitroController.value;
    solicitacaoAbastecimento.quantidade = _quantidadeController.value;
    solicitacaoAbastecimento.custoTotal = calculaValorTotalSolicitacao(
      _precoLitroController.value,
      _quantidadeController.value,
    );
    solicitacaoAbastecimento.custoVinculado = _custoVinculadoController.value;

    try {
      await Firestore.instance
          .collection('solicitacaoAbastecimento')
          .document(solicitacaoAbastecimento.identificacao)
          .setData({
        'identificacao': solicitacaoAbastecimento.identificacao,
        'detalhes': solicitacaoAbastecimento.detalhes,
        'situacaoSolicitacao': solicitacaoAbastecimento.situacaoSolicitacao,
        'solicitante': solicitacaoAbastecimento.solicitante,
        'dataAbertura': solicitacaoAbastecimento.dataAbertura,
        'dataEfetivacao': solicitacaoAbastecimento.dataEfetivacao,
        'posto': solicitacaoAbastecimento.posto,
        'tipoCombustivel': solicitacaoAbastecimento.tipoCombustivel,
        'precoLitro': solicitacaoAbastecimento.precoLitro,
        'quantidade': solicitacaoAbastecimento.quantidade,
        'custoTotal': solicitacaoAbastecimento.custoTotal,
        'custoVinculado': solicitacaoAbastecimento.custoVinculado
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
    var solicitacaoAbastecimento = SolicitacaoAbastecimento();

    solicitacaoAbastecimento.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('solicitacaoAbastecimento')
          .document(solicitacaoAbastecimento.identificacao)
          .delete()
          .then(
            (value) => alertFuncao(contextoAplicacao, 'Notificação de Sucesso',
                'Os dados do formulário foram apagados com sucesso no banco de dados!',
                () {
              Navigator.of(contextoAplicacao).pushNamed(
                '/FormularioAbastecimento',
              );
            }),
          )
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError('Erro ao apagar os dados do formulário no banco de dados!');
    }
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var solicitacaoAbastecimento = SolicitacaoAbastecimento();

    solicitacaoAbastecimento.identificacao = _idController.value;
    solicitacaoAbastecimento.detalhes = _detalhesController.value;
    solicitacaoAbastecimento.situacaoSolicitacao =
        _situacaoSolicitacaoController.value;
    solicitacaoAbastecimento.solicitante = _solicitanteController.value;
    solicitacaoAbastecimento.dataAbertura = _dataAberturaController.value;
    solicitacaoAbastecimento.dataEfetivacao = _dataEfetivacaoController.value;
    solicitacaoAbastecimento.posto = _postoController.value;
    solicitacaoAbastecimento.tipoCombustivel = _tipoCombustivelController.value;
    solicitacaoAbastecimento.precoLitro = _precoLitroController.value;
    solicitacaoAbastecimento.quantidade = _quantidadeController.value;
    // solicitacaoAbastecimento.custoTotal = calculaValorTotalSolicitacao(
    //   _precoLitroController.value,
    //   _quantidadeController.value,
    // );
    solicitacaoAbastecimento.custoVinculado = _custoVinculadoController.value;
    print(solicitacaoAbastecimento.identificacao);
    try {
      await Firestore.instance
          .collection('solicitacaoAbastecimento')
          .document(solicitacaoAbastecimento.identificacao)
          .updateData({
        'identificacao': solicitacaoAbastecimento.identificacao,
        'detalhes': solicitacaoAbastecimento.detalhes,
        'situacaoSolicitacao': solicitacaoAbastecimento.situacaoSolicitacao,
        'solicitante': solicitacaoAbastecimento.solicitante,
        'dataAbertura': solicitacaoAbastecimento.dataAbertura,
        'dataEfetivacao': solicitacaoAbastecimento.dataEfetivacao,
        'posto': solicitacaoAbastecimento.posto,
        'tipoCombustivel': solicitacaoAbastecimento.tipoCombustivel,
        'precoLitro': solicitacaoAbastecimento.precoLitro,
        'quantidade': solicitacaoAbastecimento.quantidade,
        'custoTotal': solicitacaoAbastecimento.custoTotal,
        'custoVinculado': solicitacaoAbastecimento.custoVinculado
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

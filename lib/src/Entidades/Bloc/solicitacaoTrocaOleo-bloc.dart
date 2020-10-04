import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/solicitacaoTrocaOleo.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';
import 'package:smartlogproject/src/funcoes/alertFuncao.dart';

class SolicitacaoTrocaOleoBloc extends BlocBase {
  BuildContext contextoAplicacao;

  SolicitacaoTrocaOleoBloc(BuildContext contextoAplicacao);

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
  void setOficina(String value) => _oficinaController.sink.add(value);
  void setFornecedor(String value) => _fornecedorController.sink.add(value);
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

  var _oficinaController = BehaviorSubject<String>();
  Stream<String> get outOficina => _oficinaController.stream;

  var _fornecedorController = BehaviorSubject<String>();
  Stream<String> get outFornecedor => _fornecedorController.stream;

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
    var solicitacaoTrocaOleo = SolicitacaoTrocaOleo();

    solicitacaoTrocaOleo.identificacao = _idController.value;
    solicitacaoTrocaOleo.detalhes = _detalhesController.value;
    solicitacaoTrocaOleo.situacaoSolicitacao =
        _situacaoSolicitacaoController.value;
    solicitacaoTrocaOleo.solicitante = _solicitanteController.value;
    solicitacaoTrocaOleo.dataAbertura = _dataAberturaController.value;
    solicitacaoTrocaOleo.dataEfetivacao = _dataEfetivacaoController.value;
    solicitacaoTrocaOleo.oficina = _oficinaController.value;
    solicitacaoTrocaOleo.fornecedor = _fornecedorController.value;
    solicitacaoTrocaOleo.precoLitro = _precoLitroController.value;
    solicitacaoTrocaOleo.quantidade = _quantidadeController.value;
    solicitacaoTrocaOleo.custoTotal = _custoTotalController.value;
    solicitacaoTrocaOleo.custoVinculado = _custoVinculadoController.value;

    if (solicitacaoTrocaOleo.identificacao == '' ||
        solicitacaoTrocaOleo.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a identificação!');
    } else if (solicitacaoTrocaOleo.detalhes == '' ||
        solicitacaoTrocaOleo.detalhes == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar os detalhes!');
    } else if (solicitacaoTrocaOleo.solicitante == '' ||
        solicitacaoTrocaOleo.solicitante == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar o nome do solicitante!');
    } else if (solicitacaoTrocaOleo.oficina == '' ||
        solicitacaoTrocaOleo.oficina == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a oficina!');
    } else {
      try {
        await Firestore.instance
            .collection('solicitacaoTrocaOleo')
            .document(solicitacaoTrocaOleo.identificacao)
            .setData({
          'identificacao': solicitacaoTrocaOleo.identificacao,
          'detalhes': solicitacaoTrocaOleo.detalhes,
          'situacaoSolicitacao': solicitacaoTrocaOleo.situacaoSolicitacao,
          'solicitante': solicitacaoTrocaOleo.solicitante,
          'dataAbertura': solicitacaoTrocaOleo.dataAbertura,
          'dataEfetivacao': solicitacaoTrocaOleo.dataEfetivacao,
          'oficina': solicitacaoTrocaOleo.oficina,
          'fornecedor': solicitacaoTrocaOleo.fornecedor,
          'precoLitro': solicitacaoTrocaOleo.precoLitro,
          'quantidade': solicitacaoTrocaOleo.quantidade,
          'custoTotal': solicitacaoTrocaOleo.custoTotal,
          'custoVinculado': solicitacaoTrocaOleo.custoVinculado
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

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var solicitacaoTrocaOleo = SolicitacaoTrocaOleo();

    solicitacaoTrocaOleo.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('solicitacaoTrocaOleo')
          .document(solicitacaoTrocaOleo.identificacao)
          .delete()
          .then(
            (value) => alertFuncao(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoApagar,
                () {
              Navigator.of(contextoAplicacao).pushNamed(
                '/FormularioTrocaDeOleo',
              );
            }),
          )
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError(mensagemErroApagar);
    }
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var solicitacaoTrocaOleo = SolicitacaoTrocaOleo();

    solicitacaoTrocaOleo.identificacao = _idController.value;
    solicitacaoTrocaOleo.detalhes = _detalhesController.value;
    solicitacaoTrocaOleo.situacaoSolicitacao =
        _situacaoSolicitacaoController.value;
    solicitacaoTrocaOleo.solicitante = _solicitanteController.value;
    solicitacaoTrocaOleo.dataAbertura = _dataAberturaController.value;
    solicitacaoTrocaOleo.dataEfetivacao = _dataEfetivacaoController.value;
    solicitacaoTrocaOleo.oficina = _oficinaController.value;
    solicitacaoTrocaOleo.fornecedor = _fornecedorController.value;
    solicitacaoTrocaOleo.precoLitro = _precoLitroController.value;
    solicitacaoTrocaOleo.quantidade = _quantidadeController.value;
    solicitacaoTrocaOleo.custoTotal = _custoTotalController.value;
    solicitacaoTrocaOleo.custoVinculado = _custoVinculadoController.value;
    print(solicitacaoTrocaOleo.identificacao);

    if (solicitacaoTrocaOleo.identificacao == '' ||
        solicitacaoTrocaOleo.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a identificação!');
    } else if (solicitacaoTrocaOleo.detalhes == '' ||
        solicitacaoTrocaOleo.detalhes == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar os detalhes!');
    } else if (solicitacaoTrocaOleo.solicitante == '' ||
        solicitacaoTrocaOleo.solicitante == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar o nome do solicitante!');
    } else if (solicitacaoTrocaOleo.oficina == '' ||
        solicitacaoTrocaOleo.oficina == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a oficina!');
    } else {
      try {
        await Firestore.instance
            .collection('solicitacaoTrocaOleo')
            .document(solicitacaoTrocaOleo.identificacao)
            .updateData({
          'identificacao': solicitacaoTrocaOleo.identificacao,
          'detalhes': solicitacaoTrocaOleo.detalhes,
          'situacaoSolicitacao': solicitacaoTrocaOleo.situacaoSolicitacao,
          'solicitante': solicitacaoTrocaOleo.solicitante,
          'dataAbertura': solicitacaoTrocaOleo.dataAbertura,
          'dataEfetivacao': solicitacaoTrocaOleo.dataEfetivacao,
          'oficina': solicitacaoTrocaOleo.oficina,
          'fornecedor': solicitacaoTrocaOleo.fornecedor,
          'precoLitro': solicitacaoTrocaOleo.precoLitro,
          'quantidade': solicitacaoTrocaOleo.quantidade,
          'custoTotal': solicitacaoTrocaOleo.custoTotal,
          'custoVinculado': solicitacaoTrocaOleo.custoVinculado
        }).then((value) async => await alert(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
      } catch (on) {
        TextError(mensagemSucessoSalvar);
      }
    }
  }

  Future<String> verificaAlteracaoSituacao(String numeroSolicitiacao,
      BuildContext contextoAplicacao, String origem) async {
    String mensagemRetorno = 'OK';

    void validaSituacao(DocumentSnapshot coluna, String origem) {
      if (coluna.data['situacaoSolicitacao'] == 'Negada' &&
          origem == 'EFETIVAR') {
        alert(contextoAplicacao, mensagemAlerta,
            'Não é possível realizar esta operação, pois esta programação já foi negada!');
        mensagemRetorno = 'PROG_NEGADA';
      } else if (coluna.data['situacaoSolicitacao'] == 'Efetivada' &&
          origem == 'NEGAR') {
        alert(contextoAplicacao, mensagemAlerta,
            'Não é possível realizar esta operação, pois esta programação já foi efetivada!');
        mensagemRetorno = 'PROG_EFETIVADA';
      } else if (coluna.data['situacaoSolicitacao'] == 'Negada' &&
          origem == 'NEGAR') {
        alert(contextoAplicacao, mensagemAlerta,
            'Não é possível realizar esta operação, pois esta programação já foi negada!');
        mensagemRetorno = 'PROG_EFETIVADA';
      } else if (coluna.data['situacaoSolicitacao'] == 'Efetivada' &&
          origem == 'EFETIVAR') {
        alert(contextoAplicacao, mensagemAlerta,
            'Não é possível realizar esta operação, pois esta programação já foi evetivada!');
        mensagemRetorno = 'PROG_EFETIVADA';
      }
    }

    if (numeroSolicitiacao.isNotEmpty) {
      await Firestore.instance
          .collection("solicitacaoTrocaOleo")
          .document(numeroSolicitiacao)
          .get()
          .then(
            (coluna) async => coluna.exists == false
                ? mensagemRetorno = 'SEM_DADOS'
                : validaSituacao(coluna, origem),
          );
    } else {
      mensagemRetorno = 'SEM_DADOS';
    }

    if (mensagemRetorno == 'SEM_DADOS') {
      alert(contextoAplicacao, mensagemAlerta,
          'Para realizar esta operação é necessário gravar a programação no sistema!');
    }

    return mensagemRetorno;
  }

  @override
  void dispose() {}
}

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/solicitacaoManutencao.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/alertErro.dart';
import 'package:smartlogproject/src/util/Componentes/alertFuncao.dart';

class SolicitacaoManutencaoBloc extends BlocBase {
  BuildContext contextoAplicacao;

  SolicitacaoManutencaoBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setId(String value) => _idController.sink.add(value);
  void setPrioridade(int value) => _prioridadeController.sink.add(value);
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

  var _prioridadeController = BehaviorSubject<int>();
  Stream<int> get outPrioridade => _prioridadeController.stream;

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
    solicitacaoManutencao.prioridade = _prioridadeController.value;
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

    if (solicitacaoManutencao.identificacao == '' ||
        solicitacaoManutencao.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a identificação!');
    } else if (solicitacaoManutencao.prioridade == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a prioridade!');
    } else if (solicitacaoManutencao.tipoManutencao == '' ||
        solicitacaoManutencao.tipoManutencao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar o tipo de manutenção!');
    } else if (solicitacaoManutencao.detalhes == '' ||
        solicitacaoManutencao.detalhes == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar os detalhes!');
    } else if (solicitacaoManutencao.solicitante == '' ||
        solicitacaoManutencao.solicitante == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar o nome do solicitante!');
    } else {
      try {
        await Firestore.instance
            .collection("solicitacaoManutencao")
            .document(solicitacaoManutencao.identificacao)
            .get()
            .then(
              (coluna) async => coluna.exists == true
                  ? alert(contextoAplicacao, mensagemAlerta,
                      'Esta programação já existe. Favor alterar!')
                  : await Firestore.instance
                      .collection('solicitacaoManutencao')
                      .document(solicitacaoManutencao.identificacao)
                      .setData({
                      'identificacao': solicitacaoManutencao.identificacao,
                      'prioridade': solicitacaoManutencao.prioridade,
                      'tipoManutencao': solicitacaoManutencao.tipoManutencao,
                      'detalhes': solicitacaoManutencao.detalhes,
                      'situacaoSolicitacao':
                          solicitacaoManutencao.situacaoSolicitacao,
                      'solicitante': solicitacaoManutencao.solicitante,
                      'dataAbertura': solicitacaoManutencao.dataAbertura,
                      'dataEfetivacao': solicitacaoManutencao.dataEfetivacao,
                      'oficina': solicitacaoManutencao.oficina,
                      'custoTotal': solicitacaoManutencao.custoTotal,
                      'custoVinculado': solicitacaoManutencao.custoVinculado
                    }).then(
                      (value) async => await alertFuncao(
                        contextoAplicacao,
                        mensagemNotificacao,
                        mensagemSucessoSalvar,
                        () {
                          Navigator.of(contextoAplicacao)
                              .pushNamed('/FormularioManutencao');
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
    var solicitacaoManutencao = SolicitacaoManutencao();

    solicitacaoManutencao.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('solicitacaoManutencao')
          .document(solicitacaoManutencao.identificacao)
          .delete()
          .then(
            (value) => alertFuncao(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoApagar,
                () {
              Navigator.of(contextoAplicacao)
                  .pushNamed('/FormularioManutencao');
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
    var solicitacaoManutencao = SolicitacaoManutencao();

    solicitacaoManutencao.identificacao = _idController.value;
    solicitacaoManutencao.prioridade = _prioridadeController.value;
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

    if (solicitacaoManutencao.identificacao == '' ||
        solicitacaoManutencao.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a identificação!');
    } else if (solicitacaoManutencao.prioridade == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar a prioridade!');
    } else if (solicitacaoManutencao.tipoManutencao == '' ||
        solicitacaoManutencao.tipoManutencao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar o tipo de manutenção!');
    } else if (solicitacaoManutencao.detalhes == '' ||
        solicitacaoManutencao.detalhes == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar os detalhes!');
    } else if (solicitacaoManutencao.solicitante == '' ||
        solicitacaoManutencao.solicitante == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a programação é necessário informar o nome do solicitante!');
    } else {
      try {
        await Firestore.instance
            .collection('solicitacaoManutencao')
            .document(solicitacaoManutencao.identificacao)
            .updateData({
          'identificacao': solicitacaoManutencao.identificacao,
          'prioridade': solicitacaoManutencao.prioridade,
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
                contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
      } catch (on) {
        TextError(mensagemErroSalvar);
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

    if (numeroSolicitiacao != null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para realizar esta operação é necessário gravar a carga no sistema!');
      if (numeroSolicitiacao.isNotEmpty) {
        await Firestore.instance
            .collection("solicitacaoManutencao")
            .document(numeroSolicitiacao)
            .get()
            .then(
              (coluna) async => validaSituacao(coluna, origem),
            );
      } else {
        alert(contextoAplicacao, mensagemAlerta,
            'Para realizar esta operação é necessário gravar a programação no sistema!');
      }

      return mensagemRetorno;
    }

    @override
    void dispose() {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

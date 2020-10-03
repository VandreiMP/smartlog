import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/romaneio.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';

class RomaneioBloc extends BlocBase {
  BuildContext contextoAplicacao;

  RomaneioBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setCarga(String value) => _cargaController.sink.add(value);
  void setObservacao(String value) => _observacaoController.add(value);
  void setModalidadeFrete(String value) =>
      _modalidadeFreteControllerr.add(value);
  void setDataSaidaViagem(String value) =>
      _dataSaidaViagemController.add(value);
  void setDataRetornoViagem(String value) =>
      _dataRetornoViagemController.add(value);
  void setDiasRodados(String value) => _diasRodadosController.add(value);
  void setQuilometragemRodada(String value) =>
      _quilometragemRodadaController.add(value);
  void setCidadeSaida(String value) => _cidadeSaidaController.add(value);
  void setUfSaida(String value) => _ufSaidaController.add(value);
  void setCidadeDestino(String value) => _cidadeDestinoController.add(value);
  void setUfDestino(String value) => _ufDestinoController.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _cargaController = BehaviorSubject<String>();
  Stream<String> get outCarga => _cargaController.stream;

  var _observacaoController = BehaviorSubject<String>();
  Stream<String> get outObservacao => _observacaoController.stream;

  var _modalidadeFreteControllerr = BehaviorSubject<String>();
  Stream<String> get outModalidadeFrete => _modalidadeFreteControllerr.stream;

  var _dataSaidaViagemController = BehaviorSubject<String>();
  Stream<String> get outDataSaida => _dataSaidaViagemController.stream;

  var _dataRetornoViagemController = BehaviorSubject<String>();
  Stream<String> get outDataRetorno => _dataRetornoViagemController.stream;

  var _diasRodadosController = BehaviorSubject<String>();
  Stream<String> get outDiasRodados => _diasRodadosController.stream;

  var _quilometragemRodadaController = BehaviorSubject<String>();
  Stream<String> get outQuilometragemRodada =>
      _quilometragemRodadaController.stream;

  var _cidadeSaidaController = BehaviorSubject<String>();
  Stream<String> get outCidadeSaida => _cidadeSaidaController.stream;

  var _ufSaidaController = BehaviorSubject<String>();
  Stream<String> get outUfSaida => _ufSaidaController.stream;

  var _cidadeDestinoController = BehaviorSubject<String>();
  Stream<String> get outCidadeDestino => _cidadeDestinoController.stream;

  var _ufDestinoController = BehaviorSubject<String>();
  Stream<String> get outUfDestino => _ufDestinoController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a carga e o código do romaneio como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var romaneioCarga = RomaneioCarga();

    romaneioCarga.carga = _cargaController.value;
    romaneioCarga.observacao = _observacaoController.value;
    romaneioCarga.modalidadeFrete = _modalidadeFreteControllerr.value;
    romaneioCarga.dataSaidaViagem = _dataSaidaViagemController.value;
    romaneioCarga.dataRetornoViagem = _dataRetornoViagemController.value;
    romaneioCarga.diasRodados = _diasRodadosController.value;
    romaneioCarga.quilometragemRodada = _quilometragemRodadaController.value;
    romaneioCarga.cidadeSaida = _cidadeSaidaController.value;
    romaneioCarga.ufSaida = _ufSaidaController.value;
    romaneioCarga.cidadeDestino = _cidadeDestinoController.value;
    romaneioCarga.ufDestino = _ufDestinoController.value;

    try {
      await Firestore.instance
          .collection('romaneioCarga')
          .document(romaneioCarga.carga)
          .setData({
        'carga': romaneioCarga.carga,
        'observacao': romaneioCarga.observacao,
        'modalidadeFrete': romaneioCarga.modalidadeFrete,
        'dataSaidaViagem': romaneioCarga.dataSaidaViagem,
        'dataRetornoViagem': romaneioCarga.dataRetornoViagem,
        'diasRodados': romaneioCarga.diasRodados,
        'quilometragemRodada': romaneioCarga.quilometragemRodada,
        'cidadeSaida': romaneioCarga.cidadeSaida,
        'ufSaida': romaneioCarga.ufSaida,
        'cidadeDestino': romaneioCarga.cidadeDestino,
        'ufDestino': romaneioCarga.ufDestino
      }).then((value) async => await alert(
              contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
    } catch (on) {
      TextError(mensagemErroApagar);
    }
  }

  /*
  Método que apaga os dados do formulário na tabela do Firebase.
  Primeiro busca a identificação informada no formulário através dos controllers,
  para depois excluir o registro na tabela do Firebase filtrando pela
  identificação, que é a PK desta tabela.
  */

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var romaneioCarga = RomaneioCarga();

    romaneioCarga.carga = _cargaController.value;

    try {
      await Firestore.instance
          .collection('romaneioCarga')
          .document(romaneioCarga.carga)
          .delete()
          .then((value) => {
                Navigator.of(contextoAplicacao).pushNamed(
                  '/FormularioRomaneio',
                ),
              })
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError(mensagemErroApagar);
    }
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var romaneioCarga = RomaneioCarga();

    romaneioCarga.carga = _cargaController.value;
    romaneioCarga.observacao = _observacaoController.value;
    romaneioCarga.modalidadeFrete = _modalidadeFreteControllerr.value;
    romaneioCarga.dataSaidaViagem = _dataSaidaViagemController.value;
    romaneioCarga.dataRetornoViagem = _dataRetornoViagemController.value;
    romaneioCarga.diasRodados = _diasRodadosController.value;
    romaneioCarga.quilometragemRodada = _quilometragemRodadaController.value;
    romaneioCarga.cidadeSaida = _cidadeSaidaController.value;
    romaneioCarga.ufSaida = _ufSaidaController.value;
    romaneioCarga.cidadeDestino = _cidadeDestinoController.value;
    romaneioCarga.ufDestino = _ufDestinoController.value;

    try {
      await Firestore.instance
          .collection('romaneioCarga')
          .document(romaneioCarga.carga)
          .updateData({
        'carga': romaneioCarga.carga,
        'observacao': romaneioCarga.observacao,
        'modalidadeFrete': romaneioCarga.modalidadeFrete,
        'dataSaidaViagem': romaneioCarga.dataSaidaViagem,
        'dataRetornoViagem': romaneioCarga.dataRetornoViagem,
        'diasRodados': romaneioCarga.diasRodados,
        'quilometragemRodada': romaneioCarga.quilometragemRodada,
        'cidadeSaida': romaneioCarga.cidadeSaida,
        'ufSaida': romaneioCarga.ufSaida,
        'cidadeDestino': romaneioCarga.cidadeDestino,
        'ufDestino': romaneioCarga.ufDestino
      }).then((value) async => await alert(
              contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
    } catch (on) {
      TextError(mensagemErroSalvar);
    }
  }

  @override
  void dispose() {}
}

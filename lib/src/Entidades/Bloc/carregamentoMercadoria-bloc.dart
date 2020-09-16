import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/carregamentoMercadoria.dart';
import 'package:smartlogproject/src/Entidades/classes/embalagem.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';

class CarregamentoMercadoriaBloc extends BlocBase {
  String _carga;
  String _saidaCaminhao;
  String _numeroRomaneio;
  String _situacaoExpedicao;
  String _caminhao;
  String _motorista;
  String _comprador;
  String _telefone;
  String _dataEntrega;
  String _situacaoEntrega;
  String _produto;
  String _embalagem;
  double _quantidadeEmbalagem;
  double _pesoBruto;
  double _pesoLiquido;
  double _cubagemCarga;
  double _quantidade;
  double _precoLiquido;
  double _totalCarga;

  BuildContext contextoAplicacao;

  CarregamentoMercadoriaBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setCarga(String value) => _cargaController.sink.add(value);
  void setSaidaCaminhao(String value) =>
      _saidaCaminhaoController.sink.add(value);
  void setNumeroRomaneio(String value) =>
      _numeroRomaneioController.sink.add(value);
  void setSituacaoExpedicao(String value) =>
      _situacaoExpedicaoController.sink.add(value);
  void setCaminhao(String value) => _caminhaoController.sink.add(value);
  void setMototista(String value) => _motoristaController.sink.add(value);
  void setComprador(String value) => _compradorController.sink.add(value);
  void setTelefone(String value) => _telefonController.sink.add(value);
  void setDataEntrega(String value) => _dataEntregaController.sink.add(value);
  void setSituacaoEntrega(String value) =>
      _situacaoEntregaController.sink.add(value);
  void setProduto(String value) => _produtoController.sink.add(value);
  void setEmbalagem(String value) => _embalagemController.sink.add(value);
  void setQuantidadeEmbalagem(double value) =>
      _quantidadeEmbalagemController.sink.add(value);
  void setPesoBruto(double value) => _pesoBrutoController.sink.add(value);
  void setPesoLiquido(double value) => _pesoLiquidoController.sink.add(value);
  void setCubagemCarga(double value) => _cubagemCargaController.sink.add(value);
  void setQuantidade(double value) => _quantidadeController.sink.add(value);
  void setTotalDesp(double value) => _totalDespController.sink.add(value);
  void setPrecoLiquido(double value) => _precoLiquidoController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _cargaController = BehaviorSubject<String>();
  Stream<String> get outCarga => _cargaController.stream;

  var _saidaCaminhaoController = BehaviorSubject<String>();
  Stream<String> get outSaidaCaminhao => _saidaCaminhaoController.stream;

  var _numeroRomaneioController = BehaviorSubject<String>();
  Stream<String> get outNumeroRomaneio => _numeroRomaneioController.stream;

  var _situacaoExpedicaoController = BehaviorSubject<String>();
  Stream<String> get outSituacaoExpedicao =>
      _situacaoExpedicaoController.stream;

  var _caminhaoController = BehaviorSubject<String>();
  Stream<String> get outCaminhao => _caminhaoController.stream;

  var _motoristaController = BehaviorSubject<String>();
  Stream<String> get outMotorista => _motoristaController.stream;

  var _compradorController = BehaviorSubject<String>();
  Stream<String> get outComprador => _compradorController.stream;

  var _telefonController = BehaviorSubject<String>();
  Stream<String> get outTelefone => _telefonController.stream;

  var _dataEntregaController = BehaviorSubject<String>();
  Stream<String> get outDataEntrega => _dataEntregaController.stream;

  var _situacaoEntregaController = BehaviorSubject<String>();
  Stream<String> get outSituacaoEntrega => _situacaoEntregaController.stream;

  var _produtoController = BehaviorSubject<String>();
  Stream<String> get outProduto => _produtoController.stream;

  var _quantidadeEmbalagemController = BehaviorSubject<double>();
  Stream<double> get outQuantidadeEmbalagem =>
      _quantidadeEmbalagemController.stream;

  var _embalagemController = BehaviorSubject<String>();
  Stream<String> get outEmbalagem => _embalagemController.stream;

  var _pesoBrutoController = BehaviorSubject<double>();
  Stream<double> get outPesoBruto => _pesoBrutoController.stream;

  var _pesoLiquidoController = BehaviorSubject<double>();
  Stream<double> get outPesoLiquido => _pesoLiquidoController.stream;

  var _cubagemCargaController = BehaviorSubject<double>();
  Stream<double> get outCubagemCarga => _cubagemCargaController.stream;

  var _quantidadeController = BehaviorSubject<double>();
  Stream<double> get outQuantidade => _quantidadeController.stream;

  var _precoLiquidoController = BehaviorSubject<double>();
  Stream<double> get outPrecoLiquido => _precoLiquidoController.stream;

  var _totalDespController = BehaviorSubject<double>();
  Stream<double> get outTotalDesp => _totalDespController.stream;

  var _totalCargaController = BehaviorSubject<double>();
  Stream<double> get outTotalCarga => _totalCargaController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a carga como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var carregamentoMercadoria = CarregamentoMercadoria();

    carregamentoMercadoria.carga = _cargaController.value;

    carregamentoMercadoria.saidaCaminhao = _saidaCaminhaoController.value;
    carregamentoMercadoria.numeroRomaneio = _numeroRomaneioController.value;
    carregamentoMercadoria.situacaoExpedicao =
        _situacaoExpedicaoController.value;
    carregamentoMercadoria.caminhao = _caminhaoController.value;
    carregamentoMercadoria.motorista = _motoristaController.value;
    carregamentoMercadoria.comprador = _compradorController.value;
    carregamentoMercadoria.telefone = _telefonController.value;
    carregamentoMercadoria.dataEntrega = _dataEntregaController.value;
    carregamentoMercadoria.situacaoEntrega = _situacaoEntregaController.value;
    carregamentoMercadoria.produto = _produtoController.value;
    carregamentoMercadoria.embalagem = _embalagemController.value;
    carregamentoMercadoria.quantidadeEmbalagem =
        _quantidadeEmbalagemController.value;
    carregamentoMercadoria.pesoBruto = _pesoBrutoController.value;
    carregamentoMercadoria.pesoLiquido = _pesoLiquidoController.value;
    carregamentoMercadoria.cubagemCarga = _cubagemCargaController.value;
    carregamentoMercadoria.quantidade = _quantidadeController.value;
    carregamentoMercadoria.precoLiquido = _precoLiquidoController.value;
    carregamentoMercadoria.totalDesp = _totalDespController.value;
    carregamentoMercadoria.totalCarga = calculaValorTotalCarga(
        _precoLiquidoController.value,
        _quantidadeController.value,
        _totalDespController.value);

    try {
      await Firestore.instance
          .collection('carregamentoMercadoria')
          .document(carregamentoMercadoria.carga)
          .setData({
        'carga': carregamentoMercadoria.carga,
        'saidaCaminhao': carregamentoMercadoria.saidaCaminhao,
        'numeroRomaneio': carregamentoMercadoria.numeroRomaneio,
        'situacaoExpedicao': carregamentoMercadoria.situacaoExpedicao,
        'caminhao': carregamentoMercadoria.caminhao,
        'motorista': carregamentoMercadoria.motorista,
        'comprador': carregamentoMercadoria.comprador,
        'telefone': carregamentoMercadoria.telefone,
        'dataEntrega': carregamentoMercadoria.dataEntrega,
        'situacaoEntrega': carregamentoMercadoria.situacaoEntrega,
        'produto': carregamentoMercadoria.produto,
        'embalagem': carregamentoMercadoria.embalagem,
        'quantidadeEmbalagem': carregamentoMercadoria.quantidadeEmbalagem,
        'pesoBruto': carregamentoMercadoria.pesoBruto,
        'pesoLiquido': carregamentoMercadoria.pesoLiquido,
        'cubagemCarga': carregamentoMercadoria.cubagemCarga,
        'quantidade': carregamentoMercadoria.quantidade,
        'precoLiquido': carregamentoMercadoria.precoLiquido,
        'totalDesp': carregamentoMercadoria.totalDesp,
        'totalCarga': carregamentoMercadoria.totalCarga
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
    var carregamentoMercadoria = CarregamentoMercadoria();

    carregamentoMercadoria.carga = _cargaController.value;

    try {
      await Firestore.instance
          .collection('carregamentoMercadoria')
          .document(carregamentoMercadoria.carga)
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
    var carregamentoMercadoria = CarregamentoMercadoria();

    carregamentoMercadoria.carga = _cargaController.value;
    carregamentoMercadoria.saidaCaminhao = _saidaCaminhaoController.value;
    carregamentoMercadoria.numeroRomaneio = _numeroRomaneioController.value;
    carregamentoMercadoria.situacaoExpedicao =
        _situacaoExpedicaoController.value;
    carregamentoMercadoria.caminhao = _caminhaoController.value;
    carregamentoMercadoria.motorista = _motoristaController.value;
    carregamentoMercadoria.comprador = _compradorController.value;
    carregamentoMercadoria.telefone = _telefonController.value;
    carregamentoMercadoria.dataEntrega = _dataEntregaController.value;
    carregamentoMercadoria.situacaoEntrega = _situacaoEntregaController.value;
    carregamentoMercadoria.produto = _produtoController.value;
    carregamentoMercadoria.embalagem = _embalagemController.value;
    carregamentoMercadoria.quantidadeEmbalagem =
        _quantidadeEmbalagemController.value;
    carregamentoMercadoria.pesoBruto = _pesoBrutoController.value;
    carregamentoMercadoria.pesoLiquido = _pesoLiquidoController.value;
    carregamentoMercadoria.cubagemCarga = _cubagemCargaController.value;
    carregamentoMercadoria.quantidade = _quantidadeController.value;
    carregamentoMercadoria.precoLiquido = _precoLiquidoController.value;
    carregamentoMercadoria.totalDesp = _totalDespController.value;
    carregamentoMercadoria.totalCarga = calculaValorTotalCarga(
      _precoLiquidoController.value,
      _quantidadeController.value,
      _totalDespController.value,
    );

    try {
      await Firestore.instance
          .collection('carregamentoMercadoria')
          .document(carregamentoMercadoria.carga)
          .updateData({
        'carga': carregamentoMercadoria.carga,
        'saidaCaminhao': carregamentoMercadoria.saidaCaminhao,
        'numeroRomaneio': carregamentoMercadoria.numeroRomaneio,
        'situacaoExpedicao': carregamentoMercadoria.situacaoExpedicao,
        'caminhao': carregamentoMercadoria.caminhao,
        'motorista': carregamentoMercadoria.motorista,
        'comprador': carregamentoMercadoria.comprador,
        'telefone': carregamentoMercadoria.telefone,
        'dataEntrega': carregamentoMercadoria.dataEntrega,
        'situacaoEntrega': carregamentoMercadoria.situacaoEntrega,
        'produto': carregamentoMercadoria.produto,
        'embalagem': carregamentoMercadoria.embalagem,
        'quantidadeEmbalagem': carregamentoMercadoria.quantidadeEmbalagem,
        'pesoBruto': carregamentoMercadoria.pesoBruto,
        'pesoLiquido': carregamentoMercadoria.pesoLiquido,
        'cubagemCarga': carregamentoMercadoria.cubagemCarga,
        'quantidade': carregamentoMercadoria.quantidade,
        'precoLiquido': carregamentoMercadoria.precoLiquido,
        'totalDesp': carregamentoMercadoria.totalDesp,
        'totalCarga': carregamentoMercadoria.totalCarga
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

double calculaValorTotalCarga(
    double precoLiquido, double unitario, double totalDesp) {
  return ((precoLiquido * unitario) + totalDesp);
}

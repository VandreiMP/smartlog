import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/caminhao.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/alertErro.dart';
import 'package:smartlogproject/src/util/Componentes/alertFuncao.dart';

class CaminhaoBloc extends BlocBase {
  BuildContext contextoAplicacao;

  CaminhaoBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setIdentificacao(String value) => _idController.sink.add(value);
  void setPlaca(String value) => _placaController.sink.add(value);
  void setAnoFabricacao(int value) => _anoFabricacaoController.sink.add(value);
  void setUf(String value) => _ufController.sink.add(value);
  void setDescricao(String value) => _descricaoController.sink.add(value);
  void setModeloCaminhao(String value) =>
      _modeloCaminhaoController.sink.add(value);
  void setFabricante(String value) => _fabricanteController.sink.add(value);
  void setTipoCarroceria(String value) =>
      _tipoCarroceriaController.sink.add(value);
  void setCategoriaCaminhao(String value) =>
      _categoriaCaminhaoController.sink.add(value);
  void setChassiCaminhao(String value) =>
      _chassiCaminhaoController.sink.add(value);
  void setNumeroRenavam(int value) => _numeroRenavamController.sink.add(value);
  void setNumeroRntrc(int value) => _numeroRntrcController.sink.add(value);
  void setTipoCombustivel(String value) =>
      _tipoCombustivelController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idController = BehaviorSubject<String>();
  Stream<String> get outId => _idController.stream;

  var _placaController = BehaviorSubject<String>();
  Stream<String> get outPlaca => _placaController.stream;

  var _anoFabricacaoController = BehaviorSubject<int>();
  Stream<int> get outAnoFabricacao => _anoFabricacaoController.stream;

  var _ufController = BehaviorSubject<String>();
  Stream<String> get outUf => _ufController.stream;

  var _descricaoController = BehaviorSubject<String>();
  Stream<String> get outDescricao => _descricaoController.stream;

  var _modeloCaminhaoController = BehaviorSubject<String>();
  Stream<String> get outModeloCaminhao => _modeloCaminhaoController.stream;

  var _fabricanteController = BehaviorSubject<String>();
  Stream<String> get outFabricante => _fabricanteController.stream;

  var _tipoCarroceriaController = BehaviorSubject<String>();
  Stream<String> get outTipoCarroceria => _tipoCarroceriaController.stream;

  var _categoriaCaminhaoController = BehaviorSubject<String>();
  Stream<String> get outCategoriaCaminhao =>
      _categoriaCaminhaoController.stream;

  var _chassiCaminhaoController = BehaviorSubject<String>();
  Stream<String> get outChassiCaminhao => _chassiCaminhaoController.stream;

  var _numeroRenavamController = BehaviorSubject<int>();
  Stream<int> get outNumeroRenavam => _numeroRenavamController.stream;

  var _numeroRntrcController = BehaviorSubject<int>();
  Stream<int> get outNumeroRntrc => _numeroRntrcController.stream;

  var _tipoCombustivelController = BehaviorSubject<String>();
  Stream<String> get outTipoCombustivel => _tipoCombustivelController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a identificação como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var caminhao = Caminhao();

    caminhao.identificacao = _idController.value;
    caminhao.placa = _placaController.value;
    caminhao.anoFabricacao = _anoFabricacaoController.value;
    caminhao.uf = _ufController.value;
    caminhao.descricao = _descricaoController.value;
    caminhao.modeloCaminhao = _modeloCaminhaoController.value;
    caminhao.fabricante = _fabricanteController.value;
    caminhao.tipoCarroceria = _tipoCarroceriaController.value;
    caminhao.categoriaCaminhao = _categoriaCaminhaoController.value;
    caminhao.chassiCaminhao = _chassiCaminhaoController.value;
    caminhao.numeroRenavam = _numeroRenavamController.value;
    caminhao.numeroRntrc = _numeroRntrcController.value;
    caminhao.tipoCombustivel = _tipoCombustivelController.value;

    if (caminhao.identificacao == '' || caminhao.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhão é necessário informar a identificação!');
    } else if (caminhao.placa == '' || caminhao.placa == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a placa!');
    } else if (caminhao.anoFabricacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o ano de fabricação!');
    } else if (caminhao.uf == '' || caminhao.uf == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a UF!');
    } else if (caminhao.categoriaCaminhao == '' ||
        caminhao.categoriaCaminhao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a categoria!');
    } else if (caminhao.descricao == '' || caminhao.descricao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a descrição!');
    } else if (caminhao.chassiCaminhao == '' ||
        caminhao.chassiCaminhao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o chassi!');
    } else if (caminhao.numeroRenavam == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o número do Renavam!');
    } else if (caminhao.tipoCombustivel == '' ||
        caminhao.tipoCombustivel == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o tipo de combustível!');
    } else {
      try {
        await Firestore.instance
            .collection("caminhao")
            .document(caminhao.identificacao)
            .get()
            .then(
              (coluna) async => coluna.exists == true
                  ? alert(contextoAplicacao, mensagemAlerta,
                      'Este código de caminhão já existe. Favor alterar!')
                  : await Firestore.instance
                      .collection('caminhao')
                      .document(caminhao.identificacao)
                      .setData({
                      'identificacao': caminhao.identificacao,
                      'placa': caminhao.placa,
                      'anoFabricacao': caminhao.anoFabricacao,
                      'uf': caminhao.uf,
                      'descricao': caminhao.descricao,
                      'modeloCaminhao': caminhao.modeloCaminhao,
                      'fabricante': caminhao.fabricante,
                      'tipoCarroceria': caminhao.tipoCarroceria,
                      'categoriaCaminhao': caminhao.categoriaCaminhao,
                      'chassiCaminhao': caminhao.chassiCaminhao,
                      'numeroRenavam': caminhao.numeroRenavam,
                      'numeroRntrc': caminhao.numeroRntrc,
                      'tipoCombustivel': caminhao.tipoCombustivel,
                    }).then(
                      (value) async => await alertFuncao(
                        contextoAplicacao,
                        mensagemNotificacao,
                        mensagemSucessoSalvar,
                        () {
                          Navigator.of(contextoAplicacao).pushNamed(
                              '/FormularioCaminhao',
                              arguments: caminhao.identificacao);
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
    var caminhao = Caminhao();

    caminhao.identificacao = _idController.value;
    WriteBatch transacaoBanco = Firestore.instance.batch();

    try {
      await Firestore.instance
          .collection('fichaCaminhao')
          .document(caminhao.identificacao)
          .delete();
      await Firestore.instance
          .collection('caminhao')
          .document(caminhao.identificacao)
          .delete()
          .then(
            (value) => alertFuncao(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoApagar,
                () {
              Navigator.of(contextoAplicacao).pushNamed(
                '/FormularioCaminhao',
              );
            }),
          )
          .catchError((ErrorAndStacktrace erro) {
        TextError(mensagemErroApagar);
      });
    } catch (on) {
      TextError(mensagemErroApagar);
    }
    transacaoBanco.commit();
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var caminhao = Caminhao();

    caminhao.identificacao = _idController.value;
    caminhao.placa = _placaController.value;
    caminhao.anoFabricacao = _anoFabricacaoController.value;
    caminhao.uf = _ufController.value;
    caminhao.descricao = _descricaoController.value;
    caminhao.modeloCaminhao = _modeloCaminhaoController.value;
    caminhao.fabricante = _fabricanteController.value;
    caminhao.tipoCarroceria = _tipoCarroceriaController.value;
    caminhao.categoriaCaminhao = _categoriaCaminhaoController.value;
    caminhao.chassiCaminhao = _chassiCaminhaoController.value;
    caminhao.numeroRenavam = _numeroRenavamController.value;
    caminhao.numeroRntrc = _numeroRntrcController.value;
    caminhao.tipoCombustivel = _tipoCombustivelController.value;

    if (caminhao.identificacao == '' || caminhao.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhão é necessário informar a identificação!');
    } else if (caminhao.placa == '' || caminhao.placa == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a placa!');
    } else if (caminhao.anoFabricacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o ano de fabricação!');
    } else if (caminhao.uf == '' || caminhao.uf == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a UF!');
    } else if (caminhao.categoriaCaminhao == '' ||
        caminhao.categoriaCaminhao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a categoria!');
    } else if (caminhao.descricao == '' || caminhao.descricao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar a descrição!');
    } else if (caminhao.chassiCaminhao == '' ||
        caminhao.chassiCaminhao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o chassi!');
    } else if (caminhao.numeroRenavam == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o número do Renavam!');
    } else if (caminhao.tipoCombustivel == '' ||
        caminhao.tipoCombustivel == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar o caminhao é necessário informar o tipo de combustível!');
    } else {
      try {
        await Firestore.instance
            .collection('caminhao')
            .document(caminhao.identificacao)
            .updateData({
          'identificacao': caminhao.identificacao,
          'placa': caminhao.placa,
          'anoFabricacao': caminhao.anoFabricacao,
          'uf': caminhao.uf,
          'descricao': caminhao.descricao,
          'modeloCaminhao': caminhao.modeloCaminhao,
          'fabricante': caminhao.fabricante,
          'tipoCarroceria': caminhao.tipoCarroceria,
          'categoriaCaminhao': caminhao.categoriaCaminhao,
          'chassiCaminhao': caminhao.chassiCaminhao,
          'numeroRenavam': caminhao.numeroRenavam,
          'numeroRntrc': caminhao.numeroRntrc,
          'tipoCombustivel': caminhao.tipoCombustivel,
        }).then((value) async => await alert(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
      } catch (on) {
        TextError(mensagemErroSalvar);
      }
    }
  }

  Future<void> verificaCaminhao(
      String codigoCaminhao, BuildContext contextoAplicacao) async {
    if (codigoCaminhao.isNotEmpty) {
      await Firestore.instance
          .collection("caminhao")
          .document(codigoCaminhao)
          .get()
          .then(
            (coluna) async => coluna.exists == false
                ? alert(contextoAplicacao, mensagemAlerta,
                    'Para abrir a ficha técnica no caminhão, é necessário salvar os dados do formulario!')
                : Navigator.of(contextoAplicacao).pushNamed(
                    '/FormularioCaminhaoDetalhes',
                    arguments: codigoCaminhao,
                  ),
          );
    } else {
      alert(contextoAplicacao, mensagemAlerta,
          'Para abrir a ficha técnica do caminhão, é necessário salvar os dados do formulario!');
    }
  }

  @override
  void dispose() {}
}

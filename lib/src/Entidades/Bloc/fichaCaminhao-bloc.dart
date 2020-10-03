import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/fichaCaminhao.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';

class FichaCaminhaoBloc extends BlocBase {
  BuildContext contextoAplicacao;

  FichaCaminhaoBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */
  void setIdCaminhao(String value) => _idCaminhaoController.sink.add(value);
  void setCor(String value) => _corController.sink.add(value);
  void setQuilometragemLitro(double value) =>
      _quilometragemLitroController.sink.add(value);
  void setCapacidadeCarga(double value) =>
      _capacidadeCargaController.sink.add(value);
  void setPesoVazio(double value) => _pesoVazioController.sink.add(value);
  void setNumeroEixos(int value) => _numeroEixosController.sink.add(value);
  void setComprimentoCarga(double value) =>
      _comprimentoCargaController.sink.add(value);
  void setAlturaCarga(double value) => _alturaCargaController.sink.add(value);
  void setLarguraCarga(double value) => _larguraCargaController.sink.add(value);
  void setCubagemCarga(double value) => _cubagemCargaController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */
  var _idCaminhaoController = BehaviorSubject<String>();
  Stream<String> get outIdCaminhao => _idCaminhaoController.stream;

  var _corController = BehaviorSubject<String>();
  Stream<String> get outCor => _corController.stream;

  var _quilometragemLitroController = BehaviorSubject<double>();
  Stream<double> get outQuilometragemLitro =>
      _quilometragemLitroController.stream;

  var _capacidadeCargaController = BehaviorSubject<double>();
  Stream<double> get outCapacidadeCarga => _capacidadeCargaController.stream;

  var _pesoVazioController = BehaviorSubject<double>();
  Stream<double> get outPesoVazio => _pesoVazioController.stream;

  var _numeroEixosController = BehaviorSubject<int>();
  Stream<int> get outNumeroEixos => _numeroEixosController.stream;

  var _comprimentoCargaController = BehaviorSubject<double>();
  Stream<double> get outComprimentoCarga => _comprimentoCargaController.stream;

  var _alturaCargaController = BehaviorSubject<double>();
  Stream<double> get outAlturaCarga => _alturaCargaController.stream;

  var _larguraCargaController = BehaviorSubject<double>();
  Stream<double> get outLarguraCarga => _larguraCargaController.stream;

  var _cubagemCargaController = BehaviorSubject<double>();
  Stream<double> get outCubagemCarga => _cubagemCargaController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a identificação como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var fichaCaminhao = FichaCaminhao();

    fichaCaminhao.idCaminhao = _idCaminhaoController.value;
    fichaCaminhao.cor = _corController.value;
    fichaCaminhao.quilometragemLitro = _quilometragemLitroController.value;
    fichaCaminhao.capacidadeCarga = _capacidadeCargaController.value;
    fichaCaminhao.pesoVazio = _pesoVazioController.value;
    fichaCaminhao.numeroEixos = _numeroEixosController.value;
    fichaCaminhao.comprimentoCarga = _comprimentoCargaController.value;
    fichaCaminhao.larguraCarga = _larguraCargaController.value;
    fichaCaminhao.alturaCarga = _alturaCargaController.value;
    fichaCaminhao.cubagemCarga = _cubagemCargaController.value;

    await Firestore.instance
        .collection('fichaCaminhao')
        .document(fichaCaminhao.idCaminhao)
        .setData({
      'idCaminhao': fichaCaminhao.idCaminhao,
      'cor': fichaCaminhao.cor,
      'quilometragemLitro': fichaCaminhao.quilometragemLitro,
      'capacidadeCarga': fichaCaminhao.capacidadeCarga,
      'pesoVazio': fichaCaminhao.pesoVazio,
      'numeroEixos': fichaCaminhao.numeroEixos,
      'comprimentoCarga': fichaCaminhao.comprimentoCarga,
      'larguraCarga': fichaCaminhao.larguraCarga,
      'alturaCarga': fichaCaminhao.alturaCarga,
      'cubagemCarga': fichaCaminhao.cubagemCarga
    }).then((value) async => await alert(contextoAplicacao, 'Notificação',
            'Os dados do formulário foram salvos com sucesso no banco de dados!'));
  }

  /*
  Método que apaga os dados do formulário na tabela do Firebase.
  Primeiro busca a identificação informada no formulário através dos controllers,
  para depois excluir o registro na tabela do Firebase filtrando pela
  identificação, que é a PK desta tabela.
  */

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var fichaCaminhao = FichaCaminhao();

    fichaCaminhao.idCaminhao = _idCaminhaoController.value;

    try {
      await Firestore.instance
          .collection('fichaCaminhao')
          .document(fichaCaminhao.idCaminhao)
          .delete()
          .then(
            (value) => Navigator.of(contextoAplicacao).pushNamed(
              '/FormularioCaminhaoDetalhes',
              arguments: _idCaminhaoController.value,
            ),
          )
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError('Erro ao apagar os dados do formulário no banco de dados!');
    }
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var fichaCaminhao = FichaCaminhao();

    fichaCaminhao.idCaminhao = _idCaminhaoController.value;
    fichaCaminhao.cor = _corController.value;
    fichaCaminhao.quilometragemLitro = _quilometragemLitroController.value;
    fichaCaminhao.capacidadeCarga = _capacidadeCargaController.value;
    fichaCaminhao.pesoVazio = _pesoVazioController.value;
    fichaCaminhao.numeroEixos = _numeroEixosController.value;
    fichaCaminhao.comprimentoCarga = _comprimentoCargaController.value;
    fichaCaminhao.larguraCarga = _larguraCargaController.value;
    fichaCaminhao.alturaCarga = _alturaCargaController.value;
    fichaCaminhao.cubagemCarga = _cubagemCargaController.value;

    try {
      await Firestore.instance
          .collection('fichaCaminhao')
          .document(fichaCaminhao.idCaminhao)
          .updateData({
        'idCaminhao': fichaCaminhao.idCaminhao,
        'cor': fichaCaminhao.cor,
        'quilometragemLitro': fichaCaminhao.quilometragemLitro,
        'capacidadeCarga': fichaCaminhao.capacidadeCarga,
        'pesoVazio': fichaCaminhao.pesoVazio,
        'numeroEixos': fichaCaminhao.numeroEixos,
        'comprimentoCarga': fichaCaminhao.comprimentoCarga,
        'larguraCarga': fichaCaminhao.larguraCarga,
        'alturaCarga': fichaCaminhao.alturaCarga,
        'cubagemCarga': fichaCaminhao.cubagemCarga,
      }).then((value) async => await alert(contextoAplicacao, 'Notificação',
              'Os dados do formulário foram atualizados com sucesso no banco de dados!'));
    } catch (on) {
      TextError('Erro ao atualizar os dados do formulário no banco de dados!');
    }
  }

  @override
  void dispose() {}
}

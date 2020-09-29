import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/embalagem.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:smartlogproject/src/funcoes/alertErro.dart';
import 'package:smartlogproject/src/funcoes/alertFuncao.dart';

class EmbalagemBloc extends BlocBase {
  String _documentId;
  String _descricao;
  String _categoriaEmbalagem;
  double _capacidade;
  String _tipoUnidade;
  double _largura;
  double _comprimento;
  double _altura;
  double _cubagem;
  double _tara;

  BuildContext contextoAplicacao;

  EmbalagemBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setId(String value) => _idController.sink.add(value);
  void setDescricao(String value) => _descricaoController.sink.add(value);
  void setcategoriaEmbalagem(String value) =>
      _categoriaEmbalagemController.sink.add(value);
  void setCapacidade(double value) => _capacidadeController.sink.add(value);
  void setTipoUnidade(String value) => _tipoUnidadeController.sink.add(value);
  void setLargura(double value) => _larguraController.sink.add(value);
  void setComprimento(double value) => _comprimentoController.sink.add(value);
  void setAltura(double value) => _alturaController.sink.add(value);
  void setCubagem(double value) => _cubagemController.sink.add(value);
  void setTara(double value) => _taraController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idController = BehaviorSubject<String>();
  Stream<String> get outId => _idController.stream;

  var _descricaoController = BehaviorSubject<String>();
  Stream<String> get outDescricao => _descricaoController.stream;

  var _categoriaEmbalagemController = BehaviorSubject<String>();
  Stream<String> get outCategoriaEmbalagem =>
      _categoriaEmbalagemController.stream;

  var _capacidadeController = BehaviorSubject<double>();
  Stream<double> get outCapacidade => _capacidadeController.stream;

  var _tipoUnidadeController = BehaviorSubject<String>();
  Stream<String> get outTipoUnidade => _tipoUnidadeController.stream;

  var _larguraController = BehaviorSubject<double>();
  Stream<double> get outLargura => _larguraController.stream;

  var _comprimentoController = BehaviorSubject<double>();
  Stream<double> get outComprimento => _comprimentoController.stream;

  var _alturaController = BehaviorSubject<double>();
  Stream<double> get outAltura => _alturaController.stream;

  var _cubagemController = BehaviorSubject<double>();
  Stream<double> get outCubagem => _cubagemController.stream;

  var _taraController = BehaviorSubject<double>();
  Stream<double> get outTara => _taraController.stream;

  var _controllerValorLista = BehaviorSubject<String>();
  Stream<String> get outValorLista => _controllerValorLista.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a identificação como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var embalagem = Embalagem();

    embalagem.identificacao = _idController.value;
    embalagem.descricao = _descricaoController.value;
    embalagem.categoriaEmbalagem = _categoriaEmbalagemController.value;
    embalagem.capacidade = _capacidadeController.value;
    embalagem.tipoUnidade = _tipoUnidadeController.value;
    embalagem.largura = _larguraController.value;
    embalagem.comprimento = _comprimentoController.value;
    embalagem.altura = _alturaController.value;
    embalagem.cubagem = _cubagemController.value;
    embalagem.tara = _taraController.value;

    try {
      await Firestore.instance
          .collection('embalagem')
          .document(embalagem.identificacao)
          .setData({
        'identificacao': embalagem.identificacao,
        'embalagem': embalagem.identificacao,
        'descricao': embalagem.descricao,
        'categoriaEmbalagem': embalagem.categoriaEmbalagem,
        'capacidade': embalagem.capacidade,
        'tipoUnidade': embalagem.tipoUnidade,
        'largura': embalagem.largura,
        'comprimento': embalagem.comprimento,
        'altura': embalagem.altura,
        'cubagem': embalagem.cubagem,
        'tara': embalagem.tara,
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
    var embalagem = Embalagem();

    embalagem.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('embalagem')
          .document(embalagem.identificacao)
          .delete()
          .then((value) => alertFuncao(
                  contextoAplicacao,
                  'Notificação de Sucesso',
                  'Os dados do formulário foram apagados com sucesso no banco de dados!',
                  () {
                Navigator.of(contextoAplicacao).pushNamed(
                  '/FormularioEmbalagem',
                );
              }))
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError('Erro ao apagar os dados do formulário no banco de dados!');
    }
  }

  Future<void> atualizaDados(
      BuildContext contextoAplicacao, String chaveConsulta) async {
    var embalagem = Embalagem();

    embalagem.identificacao = _idController.value;
    embalagem.descricao = _descricaoController.value;
    embalagem.categoriaEmbalagem = _categoriaEmbalagemController.value;
    embalagem.capacidade = _capacidadeController.value;
    embalagem.tipoUnidade = _tipoUnidadeController.value;
    embalagem.largura = _larguraController.value;
    embalagem.comprimento = _comprimentoController.value;
    embalagem.altura = _alturaController.value;
    embalagem.cubagem = _cubagemController.value;
    embalagem.tara = _taraController.value;

    try {
      await Firestore.instance
          .collection('embalagem')
          .document(embalagem.identificacao)
          .updateData({
        'identificacao': embalagem.identificacao,
        'embalagem': embalagem.identificacao,
        'descricao': embalagem.descricao,
        'categoriaEmbalagem': embalagem.categoriaEmbalagem,
        'capacidade': embalagem.capacidade,
        'tipoUnidade': embalagem.tipoUnidade,
        'largura': embalagem.largura,
        'comprimento': embalagem.comprimento,
        'altura': embalagem.altura,
        'cubagem': embalagem.cubagem,
        'tara': embalagem.tara,
      }).then((value) async => await alert(
              contextoAplicacao,
              'Notificação de Sucesso',
              'Os dados do formulário foram atualizados com sucesso no banco de dados!'));
    } catch (on) {
      TextError('Erro ao atualizar os dados do formulário no banco de dados!');
    }
  }

  Future<void> eventoAlteralista(String valor) async {
    _controllerValorLista.add(_controllerValorLista.value);
    // print(_controllerValorLista.stream);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

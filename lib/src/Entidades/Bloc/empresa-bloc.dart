import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/classes/empresa.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/alertErro.dart';
import 'package:smartlogproject/src/util/Componentes/alertFuncao.dart';

class EmpresaBloc extends BlocBase {
  BuildContext contextoAplicacao;

  EmpresaBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setId(String value) => _idController.sink.add(value);
  void setRazaoSocial(String value) => _razaoSocialController.sink.add(value);
  void setNomeFantasia(String value) => _nomeFantasiaController.sink.add(value);
  void setCnpj(String value) => _cnpjController.sink.add(value);
  void setInscEstadual(String value) => _inscEstadualController.sink.add(value);
  void setAtividadeEmpresa(String value) =>
      _atividadeEmpresaController.sink.add(value);
  void setMatrizFilial(String value) => _matrizFilialController.sink.add(value);
  void setTelefone(String value) => _telefoneController.sink.add(value);
  void setEmail(String value) => _emailController.sink.add(value);
  void setEndereco(String value) => _enderecoController.sink.add(value);
  void setCidade(String value) => _cidadeController.sink.add(value);
  void setUf(String value) => _ufController.sink.add(value);
  void setBairro(String value) => _bairroController.sink.add(value);
  void setCep(String value) => _cepController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _idController = BehaviorSubject<String>();
  Stream<String> get outId => _idController.stream;

  var _razaoSocialController = BehaviorSubject<String>();
  Stream<String> get outRazaoSocial => _razaoSocialController.stream;

  var _nomeFantasiaController = BehaviorSubject<String>();
  Stream<String> get outNomeFantasia => _nomeFantasiaController.stream;

  var _cnpjController = BehaviorSubject<String>();
  Stream<String> get outCnpj => _cnpjController.stream;

  var _inscEstadualController = BehaviorSubject<String>();
  Stream<String> get outInscEstadual => _inscEstadualController.stream;

  var _atividadeEmpresaController = BehaviorSubject<String>();
  Stream<String> get outAtividadeEmpresa => _atividadeEmpresaController.stream;

  var _matrizFilialController = BehaviorSubject<String>();
  Stream<String> get outMatrizFilial => _matrizFilialController.stream;

  var _telefoneController = BehaviorSubject<String>();
  Stream<String> get outTelefone => _telefoneController.stream;

  var _emailController = BehaviorSubject<String>();
  Stream<String> get outEmail => _emailController.stream;

  var _enderecoController = BehaviorSubject<String>();
  Stream<String> get outEndereco => _enderecoController.stream;

  var _cidadeController = BehaviorSubject<String>();
  Stream<String> get outCidade => _cidadeController.stream;

  var _ufController = BehaviorSubject<String>();
  Stream<String> get outUf => _ufController.stream;

  var _bairroController = BehaviorSubject<String>();
  Stream<String> get outBairro => _bairroController.stream;

  var _cepController = BehaviorSubject<String>();
  Stream<String> get outCep => _cepController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a identificação como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var empresa = Empresa();

    empresa.identificacao = _idController.value;
    empresa.razaoSocial = _razaoSocialController.value;
    empresa.nomeFantasia = _nomeFantasiaController.value;
    empresa.cnpj = _cnpjController.value;
    empresa.inscEstadual = _inscEstadualController.value;
    empresa.atividadeEmpresa = _atividadeEmpresaController.value;
    empresa.matrizFilial = _matrizFilialController.value;
    empresa.telefone = _telefoneController.value;
    empresa.email = _emailController.value;
    empresa.endereco = _enderecoController.value;
    empresa.cidade = _cidadeController.value;
    empresa.uf = _ufController.value;
    empresa.bairro = _bairroController.value;
    empresa.cep = _cepController.value;

    if (empresa.identificacao == '' || empresa.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar a identificação!');
    } else if (empresa.razaoSocial == '' || empresa.razaoSocial == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar a razão social!');
    } else if (empresa.nomeFantasia == '' || empresa.nomeFantasia == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar o nome fantasia!');
    } else if (empresa.cnpj == '' || empresa.cnpj == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar o CNPJ!');
    } else if (empresa.inscEstadual == '' || empresa.inscEstadual == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar a inscrição estuadual!');
    } else if (empresa.atividadeEmpresa == '' ||
        empresa.atividadeEmpresa == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar o ramo de atidade!');
    } else if (empresa.matrizFilial == '' || empresa.matrizFilial == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar se a mesma é matriz ou filial!');
    } else {
      await Firestore.instance
          .collection("empresa")
          .document(empresa.identificacao)
          .get()
          .then(
            (coluna) async => coluna.exists == true
                ? alert(contextoAplicacao, mensagemAlerta,
                    'Este código de empresa já existe. Favor alterar!')
                : Firestore.instance
                    .collection('empresa')
                    .document(empresa.identificacao)
                    .setData({
                    'identificacao': empresa.identificacao,
                    'razaoSocial': empresa.razaoSocial,
                    'nomeFantasia': empresa.nomeFantasia,
                    'cnpj': empresa.cnpj,
                    'inscEstadual': empresa.inscEstadual,
                    'atividadeEmpresa': empresa.atividadeEmpresa,
                    'matrizFilial': empresa.matrizFilial,
                    'telefone': empresa.telefone,
                    'email': empresa.email,
                    'endereco': empresa.endereco,
                    'cidade': empresa.cidade,
                    'bairro': empresa.bairro,
                    'uf': empresa.uf,
                    'cep': empresa.cep
                  }).then(
                    (value) async => await alertFuncao(
                      contextoAplicacao,
                      mensagemNotificacao,
                      mensagemSucessoSalvar,
                      () {
                        Navigator.of(contextoAplicacao).pushNamed(
                            '/FormularioEmpresa',
                            arguments: empresa.identificacao);
                      },
                    ),
                  ),
          );
    }
  }

  /*
  Método que apaga os dados do formulário na tabela do Firebase.
  Primeiro busca a identificação informada no formulário através dos controllers,
  para depois excluir o registro na tabela do Firebase filtrando pela
  identificação, que é a PK desta tabela.
  */

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var empresa = Empresa();

    empresa.identificacao = _idController.value;

    try {
      await Firestore.instance
          .collection('responsavelEmpresa')
          .document(empresa.identificacao)
          .delete()
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
      await Firestore.instance
          .collection('empresa')
          .document(empresa.identificacao)
          .delete()
          .then(
            (value) => alertFuncao(
              contextoAplicacao,
              mensagemNotificacao,
              mensagemSucessoApagar,
              () {
                Navigator.of(contextoAplicacao).pushNamed(
                  '/FormularioEmpresa',
                );
              },
            ),
          )
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError(mensagemErroApagar);
    }
  }

  Future<void> atualizaDados(
      BuildContext contextoAplicacao, String chaveConsulta) async {
    var empresa = Empresa();

    empresa.identificacao = _idController.value;
    empresa.razaoSocial = _razaoSocialController.value;
    empresa.nomeFantasia = _nomeFantasiaController.value;
    empresa.cnpj = _cnpjController.value;
    empresa.inscEstadual = _inscEstadualController.value;
    empresa.atividadeEmpresa = _atividadeEmpresaController.value;
    empresa.matrizFilial = _matrizFilialController.value;
    empresa.telefone = _telefoneController.value;
    empresa.email = _emailController.value;
    empresa.endereco = _enderecoController.value;
    empresa.cidade = _cidadeController.value;
    empresa.uf = _ufController.value;
    empresa.bairro = _bairroController.value;
    empresa.cep = _cepController.value;

    if (empresa.identificacao == '' || empresa.identificacao == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar a identificação!');
    } else if (empresa.razaoSocial == '' || empresa.razaoSocial == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar a razão social!');
    } else if (empresa.nomeFantasia == '' || empresa.nomeFantasia == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar o nome fantasia!');
    } else if (empresa.cnpj == '' || empresa.cnpj == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar o CNPJ!');
    } else if (empresa.inscEstadual == '' || empresa.inscEstadual == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar a inscrição estuadual!');
    } else if (empresa.atividadeEmpresa == '' ||
        empresa.atividadeEmpresa == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar o ramo de atidade!');
    } else if (empresa.matrizFilial == '' || empresa.matrizFilial == null) {
      alert(contextoAplicacao, mensagemAlerta,
          'Para salvar a empresa é necessário informar se a mesma é matriz ou filial!');
    } else {
      try {
        await Firestore.instance
            .collection('empresa')
            .document(chaveConsulta)
            .updateData({
          'identificacao': empresa.identificacao,
          'razaoSocial': empresa.razaoSocial,
          'nomeFantasia': empresa.nomeFantasia,
          'cnpj': empresa.cnpj,
          'inscEstadual': empresa.inscEstadual,
          'atividadeEmpresa': empresa.atividadeEmpresa,
          'matrizFilial': empresa.matrizFilial,
          'telefone': empresa.telefone,
          'email': empresa.email,
          'endereco': empresa.endereco,
          'cidade': empresa.cidade,
          'bairro': empresa.bairro,
          'uf': empresa.uf,
          'cep': empresa.cep
        }).then((value) async => await alert(
                contextoAplicacao, mensagemNotificacao, mensagemSucessoSalvar));
      } catch (on) {
        TextError(
            'Erro ao atualizar os dados do formulário no banco de dados!');
      }
    }
  }

  Future<void> verificaEmpresa(
      String codigoEmpresa, BuildContext contextoAplicacao) async {
    if (codigoEmpresa.isNotEmpty) {
      await Firestore.instance
          .collection("empresa")
          .document(codigoEmpresa)
          .get()
          .then(
            (coluna) async => coluna.exists == false
                ? alert(contextoAplicacao, mensagemAlerta,
                    'Para abrir as informações do responsável, é necessário salvar os dados do formulario!')
                : Navigator.of(contextoAplicacao).pushNamed(
                    '/FormularioEmpresaDetalhes',
                    arguments: codigoEmpresa,
                  ),
          );
    } else {
      alert(contextoAplicacao, mensagemAlerta,
          'Para abrir as informações do responsável, é necessário salvar os dados do formulario!');
    }
  }

  @override
  void dispose() {}
}

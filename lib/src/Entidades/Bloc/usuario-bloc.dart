import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/usuario/usuario.dart';

class UsuarioBloc extends BlocBase {
  String _documentId;
  String _nome;
  String _tpUsuario;
  String _senha;
  String _email;
  String _telefone;
  String _celular;
  int _ramal;

  UsuarioBloc() {
    _nomeController.listen((value) => _nome = value);
    _tpUsuarioController.listen((value) => _tpUsuario = value);
    _emailController.listen((value) => _email = value);
    _senhaController.listen((value) => _senha = value);
    _telefoneController.listen((value) => _email = value);
    _celularController.listen((value) => _telefone = value);
    _ramalController.listen((value) => _ramal = value);
  }

  void setNome(String value) => _nomeController.sink.add(value);
  void setTpUsuario(String value) => _tpUsuarioController.sink.add(value);
  void setSenha(String value) => _senhaController.sink.add(value);
  void setEmail(String value) => _emailController.sink.add(value);
  void setTelefone(String value) => _telefoneController.sink.add(value);
  void setCelular(String value) => _celularController.sink.add(value);
  void setRamal(int value) => _ramalController.sink.add(value);

  void setUsuario(Usuario usuario) {
    _documentId = usuario.documentId();
    setNome(usuario.nome);
    setTpUsuario(usuario.tpUsuario);
    setSenha(usuario.senha);
    setEmail(usuario.email);
    setTelefone(usuario.telefone);
    setCelular(usuario.celular);
    setRamal(usuario.ramal);
  }

  var _idController = BehaviorSubject<int>();
  Stream<int> get outId => _idController.stream;

  var _nomeController = BehaviorSubject<String>();
  Stream<String> get outName => _nomeController.stream;

  var _tpUsuarioController = BehaviorSubject<String>();
  Stream<String> get outTpusuario => _tpUsuarioController.stream;

  var _emailController = BehaviorSubject<String>();
  Stream<String> get outEmail => _emailController.stream;

  var _senhaController = BehaviorSubject<String>();
  Stream<String> get outSenha => _senhaController.stream;

  var _telefoneController = BehaviorSubject<String>();
  Stream<String> get outTelefone => _telefoneController.stream;

  var _celularController = BehaviorSubject<String>();
  Stream<String> get outCelular => _celularController.stream;

  var _ramalController = BehaviorSubject<int>();
  Stream<int> get outRamal => _ramalController.stream;

   insertOrUpdate() {
    var usuario = Usuario()
      ..nome = _nome
      ..tpUsuario = _tpUsuario
      ..email = _email
      ..senha = _senha
      ..telefone = _telefone
      ..celular = _celular
      ..ramal = _ramal;

    Firestore.instance
        .collection('user')
        .document('104')
        .updateData({'ramal': usuario.ramal});

    // if (_documentId?.isEmpty ?? true) {
    //   Firestore.instance.collection('user').document(_documentId).setData;
    // } else {
    //   _repository.update(_documentId, usuario);
    // }

    return true;
  }

  @override
  void dispose() {}
}

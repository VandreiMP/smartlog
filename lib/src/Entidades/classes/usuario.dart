import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class Usuario extends BaseModel {
  String identificacao;
  String nome;
  String tpUsuario;
  String senha;
  String emailLogin;
  String email;
  String telefone;
  String celular;
  String ramal;

  Usuario();

  // Usuario.fromJson(Map<String, dynamic> json)
  //     : identificacao = json['identificacao'],
  //       nome = json['nome'],
  //       tpUsuario = json['tpUsuario'],
  //       senha = json['senha'],
  //       emailLogin = json['emailLogin'],
  //       email = json['email'],
  //       celular = json['celular'],
  //       telefone = json['telefone'],
  //       ramal = json['ramal'];

  Usuario.fromMap(DocumentSnapshot document) {
    // print('dentro do objeto');
    // print(document.data['nome']);
    this.identificacao = document.data["identificacao"];
    this.nome = document.data["nome"];
    // // this.tpUsuario = document.data["tpUsuario"];
    // this.senha = document.data["senha"];
    // this.emailLogin = document.data['emailLogin'];
    // this.email = document.data["email"];
    // this.telefone = document.data["telefone"];
    // this.celular = document.data["celular"];
    // this.ramal = document.data["ramal"];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['identificacao'] = this.identificacao;
      map['nome'] = this.nome;
      // // map['tpUsuario'] = this.tpUsuario;
      // map['senha'] = this.senha;
      // map['email'] = this.email;
      // map['emailLogin'] = this.emailLogin;
      // map['telefone'] = this.telefone;
      // map['celular'] = this.celular;
      // map['ramal'] = this.ramal;

      return map;
    }

    @override
    //   String documentId() => _documentId;
    // }

    @override
    String documentId() {
      // TODO: implement documentId
      throw UnimplementedError();
    }
  }

  @override
  String documentId() {
    // TODO: implement documentId
    throw UnimplementedError();
  }

  @override
  toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  String get getNome {
    return this.nome;
  }
}

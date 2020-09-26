import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class ResponsavelEmpresa extends BaseModel {
  String identificacaoEmpresa;
  String nome;
  String rg;
  String cpf;
  String cargo;
  String email;

  ResponsavelEmpresa();

  ResponsavelEmpresa.fromMap(DocumentSnapshot document) {
    this.identificacaoEmpresa = document.data["identificacaoEmpresa"];
    this.nome = document.data['nome'];
    this.rg = document.data['rg'];
    this.cpf = document.data['cpf'];
    this.cargo = document.data['cargo'];
    this.email = document.data['email'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['identificacaoEmpresa'] = this.identificacaoEmpresa;
      map['nome'] = this.nome;
      map['rg'] = this.rg;
      map['cpf'] = this.cpf;
      map['cargo'] = this.cargo;
      map['email'] = this.email;

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
}

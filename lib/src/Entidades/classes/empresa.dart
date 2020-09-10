import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class Empresa extends BaseModel {
  String identificacao;
  String razaoSocial;
  String nomeFantasia;
  String cnpj;
  String inscEstadual;
  String atividadeEmpresa;
  String matrizFilial;
  String telefone;
  String email;
  String endereco;
  String cidade;
  String uf;
  String bairro;
  String cep;

  Empresa();

  Empresa.fromMap(DocumentSnapshot document) {
    this.identificacao = document.data["identificacao"];
    this.razaoSocial = document.data["razaoSocial"];
    this.nomeFantasia = document.data["nomeFantasia"];
    this.cnpj = document.data['cnpj'];
    this.inscEstadual = document.data['inscEstadual'];
    this.atividadeEmpresa = document.data['atividadeEmpresa'];
    this.matrizFilial = document.data['matrizFilial'];
    this.telefone = document.data['telefone'];
    this.email = document.data['email'];
    this.endereco = document.data['endereco'];
    this.cidade = document.data['cidade'];
    this.uf = document.data['uf'];
    this.bairro = document.data['bairro'];
    this.cep = document.data['cep'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['identificacao'] = this.identificacao;
      map['razaoSocial'] = this.razaoSocial;
      map['nomeFantasia'] = this.nomeFantasia;
      map['cnpj'] = this.cnpj;
      map['inscEstadual'] = this.inscEstadual;
      map['atividadeEmpresa'] = this.atividadeEmpresa;
      map['matrizFilial'] = this.matrizFilial;
      map['telefone'] = this.telefone;
      map['email'] = this.email;
      map['endereco'] = this.endereco;
      map['cidade'] = this.cidade;
      map['uf'] = this.uf;
      map['bairro'] = this.bairro;
      map['cep'] = this.cep;

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

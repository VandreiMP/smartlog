import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class Caminhao extends BaseModel {
  String identificacao;
  String placa;
  int anoFabricacao;
  String uf;
  String descricao;
  String modeloCaminhao;
  String fabricante;
  String tipoCarroceria;
  String categoriaCaminhao;
  String chassiCaminhao;
  int numeroRenavam;
  int numeroRntrc;
  String tipoCombustivel;

  Caminhao();

  Caminhao.fromMap(DocumentSnapshot document) {
    this.identificacao = document.data['identificacao'];
    this.placa = document.data["placa"];
    this.anoFabricacao = document.data['anoFabricacao'];
    this.uf = document.data['uf'];
    this.descricao = document.data['descricao'];
    this.modeloCaminhao = document.data['modeloCaminhao'];
    this.fabricante = document.data['fabricante'];
    this.tipoCarroceria = document.data['tipoCarroceria'];
    this.categoriaCaminhao = document.data['categoriaCaminhao'];
    this.chassiCaminhao = document.data['chassiCaminhao'];
    this.numeroRenavam = document.data['numeroRenavam'];
    this.numeroRntrc = document.data['numeroRntrc'];
    this.tipoCombustivel = document.data['tipoCombustivel'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['identificacao'] = this.identificacao;
      map['placa'] = this.placa;
      map['anoFabricacao'] = this.anoFabricacao;
      map['uf'] = this.uf;
      map['descricao'] = this.descricao;
      map['modeloCaminhao'] = this.modeloCaminhao;
      map['fabricante'] = this.fabricante;
      map['tipoCarroceria'] = this.tipoCarroceria;
      map['categoriaCaminhao'] = this.categoriaCaminhao;
      map['chassiCaminhao'] = this.chassiCaminhao;
      map['numeroRenavam'] = this.numeroRenavam;
      map['numeroRntrc'] = this.numeroRntrc;
      map['tipoCombustivel'] = this.tipoCombustivel;

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

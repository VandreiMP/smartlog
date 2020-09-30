import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class FichaCaminhao extends BaseModel {
  String idCaminhao;
  String cor;
  double quilometragemLitro;
  double capacidadeCarga;
  double pesoVazio;
  int numeroEixos;
  double comprimentoCarga;
  double alturaCarga;
  double larguraCarga;
  double cubagemCarga;


  FichaCaminhao();

  FichaCaminhao.fromMap(DocumentSnapshot document) {
    this.idCaminhao = document.data['idCaminhao'];
    this.cor = document.data['cor'];
    this.quilometragemLitro = document.data['quilometragemLitro'];
    this.capacidadeCarga = document.data['capacidadeCarga'];
    this.pesoVazio = document.data['pesoVazio'];
    this.numeroEixos = document.data['numeroEixos'];
    this.comprimentoCarga = document.data['comprimentoCarga'];
    this.alturaCarga = document.data['alturaCarga'];
    this.larguraCarga = document.data['larguraCarga'];
    this.cubagemCarga = document.data['cubagemCarga'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['idCaminhao'] = this.idCaminhao;
      map['cor'] = this.quilometragemLitro;
      map['quilometragemLitro'] = this.cor;
      map['capacidadeCarga'] = this.capacidadeCarga;
      map['pesoVazio'] = this.pesoVazio;
      map['numeroEixos'] = this.numeroEixos;
      map['comprimentoCarga'] = this.comprimentoCarga;
      map['alturaCarga'] = this.alturaCarga;
      map['larguraCarga'] = this.larguraCarga;
      map['cubagemCarga'] = this.cubagemCarga;

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

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class RomaneioCarga extends BaseModel {
  String carga;
  String observacao;
  String modalidadeFrete;
  String dataSaidaViagem;
  String dataRetornoViagem;
  String diasRodados;
  String quilometragemRodada;
  String cidadeSaida;
  String ufSaida;
  String cidadeDestino;
  String ufDestino;

  RomaneioCarga();

  RomaneioCarga.fromMap(DocumentSnapshot document) {
    this.carga = document.data['carga'];
    this.observacao = document['observacao'];
    this.modalidadeFrete = document['modalidade'];
    this.dataSaidaViagem = document['dataSaidaViagem'];
    this.dataRetornoViagem = document['dataRetornoViagem'];
    this.diasRodados = document['diasRodados'];
    this.quilometragemRodada = document['quilometragemRodada'];
    this.cidadeSaida = document['cidadeSaida'];
    this.ufSaida = document['ufSaida'];
    this.cidadeDestino = document['cidadeDestino'];
    this.ufDestino = document['ufDestino'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['carga'] = this.carga;
      map['observacao'] = this.observacao;
      map['modalidadeFrete'] = this.modalidadeFrete;
      map['dataSaidaViagem'] = this.dataSaidaViagem;
      map['dataRetornoViagem'] = this.dataRetornoViagem;
      map['diasRodados'] = this.diasRodados;
      map['quilometragemRodada'] = this.quilometragemRodada;
      map['cidadeSaida'] = this.cidadeSaida;
      map['ufSaida'] = this.ufSaida;
      map['cidadeDestino'] = this.cidadeDestino;
      map['ufDestino'] = this.ufDestino;

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

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class Embalagem extends BaseModel {
  String identificacao;
  String descricao;
  String categoriaEmbalagem;
  String capacidade;
  String tipoUnidade;
  String largura;
  String comprimento;
  String tara;

  Embalagem();

  Embalagem.fromMap(DocumentSnapshot document) {
    this.identificacao = document.data["identificacao"];
    this.descricao = document.data["descricao"];
    // this.categoriaEmbalagem = document.data["categoriaEmbalagem"];
    this.capacidade = document.data["capacidade"];
    // this.tipoUnidade = document.data['tipoUnidade'];
    this.largura = document.data["largura"];
    this.comprimento = document.data["comprimento"];
    this.tara = document.data["tara"];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['identificacao'] = this.identificacao;
      map['descricao'] = this.descricao;
      // map['categoriaEmbalagem'] = this.categoriaEmbalagem;
      map['capacidade'] = this.capacidade;
      // map['tipoUnidade'] = this.tipoUnidade;
      map['largura'] = this.largura;
      map['comprimento'] = this.comprimento;
      map['tara'] = this.tara;

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
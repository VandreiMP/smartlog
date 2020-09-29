import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class Custo extends BaseModel {
  String identificacao;
  String detalhes;
  String modalidade;
  String periodicidade;
  String analiseGerencial;
  double valor;

  Custo();

  fromMap(DocumentSnapshot document) {
    this.identificacao = document.data["identificacao"];
    this.detalhes = document.data["detalhes"];
    this.modalidade = document.data["modalidade"];
    this.valor = document.data["valor"];
    this.periodicidade = document.data['periodicidade'];
    this.analiseGerencial = document.data["analiseGerencial"];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['identificacao'] = this.identificacao;
      map['detalhes'] = this.detalhes;
      map['modalidade'] = this.modalidade;
      map['valor'] = this.valor;
      map['periodicidade'] = this.periodicidade;
      map['analiseGerencial'] = this.analiseGerencial;
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

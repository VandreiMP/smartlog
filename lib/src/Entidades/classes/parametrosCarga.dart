import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class ParametrosCarga extends BaseModel {
  String carga;
  String dataSaida;

  ParametrosCarga();

  ParametrosCarga.fromMap(DocumentSnapshot document) {
    this.carga = document.data['carga'];
    this.dataSaida = document['dataSaida'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['carga'] = this.carga;
      map['dataSaida'] = this.dataSaida;

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

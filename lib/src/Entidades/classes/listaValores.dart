import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class ListaValores extends BaseModel {
  String identificacao;
  String descricao;

  ListaValores();

  ListaValores.fromMap(String identificacao, String descricao) {
    this.identificacao = identificacao;
    this.descricao = descricao;
  }

  @override
  //   String documentId() => _documentId;
  // }

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

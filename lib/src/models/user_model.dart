// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:smartlogproject/src/shared/base_model.dart';

// class User {

//   String _documentId;
//   String nome;
//   int identificacao;
//   String tp_usuario;
//   String login;
//   String senha;
//   String e_mail;
//   String telefone;
//   String celular;
//   String ramal;

//   toMap() {
//     var map = new Map<String, dynamic>();
//     map['nome'] = this.nome;
//     map['identificacao'] = this.identificacao;
//     map['tp_usuario'] = this.tp_usuario;
//     map['login'] = this.login;
//     map['e_mail'] = this.e_mail;
//     map['celular'] = this.celular;
//     map['ramal'] = this.ramal;
//     return map;
//   }

// }



// class Carro {
//   int id;
//   String nome;
//   String tipo;
//   String descricao;
//   String urlFoto;
//   String urlVideo;
//   String latitude;
//   String longitude;

//   Carro(
//       {this.id,
//       this.nome,
//       this.tipo,
//       this.descricao,
//       this.urlFoto,
//       this.urlVideo,
//       this.latitude,
//       this.longitude});

//   Carro.fromMap(Map<String, dynamic> map) {
//     id = map['id'];
//     nome = map['nome'];
//     tipo = map['tipo'];
//     descricao = map['descricao'];
//     urlFoto = map['urlFoto'];
//     urlVideo = map['urlVideo'];
//     latitude = map['latitude'];
//     longitude = map['longitude'];
//   }

//   Map<String, dynamic> toMap() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = this.id;
//     data['nome'] = this.nome;
//     data['tipo'] = this.tipo;
//     data['descricao'] = this.descricao;
//     data['urlFoto'] = this.urlFoto;
//     data['urlVideo'] = this.urlVideo;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }

//   String toJson() {
//     String json = convert.json.encode(toMap());
//     return json;
//   }

//   @override
//   String toString() {
//     return 'Carro{id: $id, nome: $nome, tipo: $tipo, descricao: $descricao, urlFoto: $urlFoto, urlVideo: $urlVideo, latitude: $latitude, longitude: $longitude}';
//   }
// }
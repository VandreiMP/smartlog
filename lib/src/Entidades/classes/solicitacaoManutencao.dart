import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class SolicitacaoManutencao extends BaseModel {
  String identificacao;
  int prioridade;
  String tipoManutencao;
  String detalhes;
  String situacaoSolicitacao;
  String solicitante;
  String dataAbertura;
  String dataEfetivacao;
  String oficina;
  double custoTotal;
  String custoVinculado;

  SolicitacaoManutencao();

  SolicitacaoManutencao.fromMap(DocumentSnapshot document) {
    this.identificacao = document.data["identificacao"];
    this.prioridade = document.data['prioridade'];
    this.tipoManutencao = document.data['tipoManutencao'];
    this.detalhes = document.data["detalhes"];
    this.situacaoSolicitacao = document.data['situacaoSolicitacao'];
    this.solicitante = document.data['solicitante'];
    this.dataAbertura = document.data['dataAbertura'];
    this.dataEfetivacao = document.data['dataEfetivacao'];
    this.oficina = document.data['oficina'];
    this.custoTotal = document.data['custoTotal'];
    this.custoVinculado = document.data['custoVinculado'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['identificacao'] = this.identificacao;
      map['prioridade'] = this.prioridade;
      map['tipoManutencao'] = this.tipoManutencao;
      map['detalhes'] = this.detalhes;
      map['situacaoSolicitacao'] = this.situacaoSolicitacao;
      map['solicitante'] = this.solicitante;
      map['dataAbertura'] = this.dataAbertura;
      map['dataEfetivacao'] = this.dataEfetivacao;
      map['oficina'] = this.oficina;
      map['custoTotal'] = this.custoTotal;
      map['custoVinculado'] = this.custoVinculado;

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

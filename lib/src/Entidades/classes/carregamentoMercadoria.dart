import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class CarregamentoMercadoria extends BaseModel {
  String carga;
  String saidaCaminhao;
  String numeroRomaneio;
  String situacaoExpedicao;
  String caminhao;
  String motorista;
  String comprador;
  String telefone;
  String dataEntrega;
  String situacaoEntrega;
  String produto;
  String embalagem;
  double quantidadeEmbalagem;
  double pesoBruto;
  double pesoLiquido;
  double cubagemCarga;
  double quantidade;
  double precoLiquido;
  double totalDesp;
  double totalCarga;

  CarregamentoMercadoria();

  CarregamentoMercadoria.fromMap(DocumentSnapshot document) {
    this.carga = document.data['carga'];
    this.saidaCaminhao = document.data['saidaCaminhao'];
    this.numeroRomaneio = document.data['numeroRomaneio'];
    this.situacaoExpedicao = document.data['situacaoExpedicao'];
    this.caminhao = document.data['caminhao'];
    this.motorista = document.data['motorista'];
    this.comprador = document.data['comprador'];
    this.telefone = document.data['telefone'];
    this.dataEntrega = document.data['dataEntrega'];
    this.situacaoEntrega = document.data['situacaoEntrega'];
    this.produto = document.data['produto'];
    this.embalagem = document.data['embalagem'];
    this.quantidadeEmbalagem = document.data['quantidadeEmbalagem'];
    this.pesoBruto = document.data['pesoBruto'];
    this.pesoLiquido = document.data['pesoLiquido'];
    this.cubagemCarga = document.data['cubagemCarga'];
    this.quantidade = document.data['quantidade'];
    this.precoLiquido = document.data['precoLiquido'];
    this.totalDesp = document.data['totalDesp'];
    this.totalCarga = document.data['totalCarga'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['carga'] = this.carga;
      map['saidaCaminhao'] = this.saidaCaminhao;
      map['numeroRomaneio'] = this.numeroRomaneio;
      map['situacaoExpedicao'] = this.situacaoExpedicao;
      map['caminhao'] = this.caminhao;
      map['motorista'] = this.motorista;
      map['comprador'] = this.comprador;
      map['telefone'] = this.telefone;
      map['dataEntrega'] = this.dataEntrega;
      map['situacaoEntrega'] = this.situacaoEntrega;
      map['produto'] = this.produto;
      map['embalagem'] = this.embalagem;
      map['quantidadeEmbalagem'] = this.quantidadeEmbalagem;
      map['pesoBruto'] = this.pesoBruto;
      map['pesoLiquido'] = this.pesoLiquido;
      map['cubagemCarga'] = this.cubagemCarga;
      map['quantidade'] = this.quantidade;
      map['precoLiquido'] = this.precoLiquido;
      map['totalDesp'] = this.totalDesp;
      map['totalCarga'] = this.totalCarga;

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

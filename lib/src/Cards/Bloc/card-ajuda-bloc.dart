import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/AcessoSistema/Widget/acesso-sistema-widget.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjuda.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjudaAdicionais.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjudaCarga.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjudaContrato.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjudaCustos.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjudaDetalhes.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjudaEmpresa.dart';
import 'package:smartlogproject/src/Cards/Widgets/criaCardAjudaRomaneio.dart';
import 'package:smartlogproject/src/screen/visaoGeral.dart';

class CardAjudaBloc extends BlocBase {
  var _controllerExibeCard = BehaviorSubject<bool>(seedValue: true);
  var _controllerCardAjuda = BehaviorSubject<String>(seedValue: 'AcessoSistemaWidget()');

  Stream<bool> get outExibeCard => _controllerExibeCard.stream;
  Stream<String> get outCardAjuda => _controllerCardAjuda.stream;

  final BuildContext contextoAplicacao;
  final String origem;

  CardAjudaBloc(this.contextoAplicacao, this.origem);

  Future<void> eventoCliqueBotaoAjuda() async {
    
    _controllerExibeCard.add(!_controllerExibeCard.value);

    _controllerCardAjuda.add('CriaCardAjudaEmpresa()');

    // if (origem == 'GERAL' ||
    //     origem == 'RESPONSAVEL' ||
    //     origem == 'DESPESAS_CONTRATO') {
    //   _controllerCardAjuda.add(CriaCardAjuda());
    // }
    // if (origem == 'ADICIONAIS') {
    //   _controllerCardAjuda.add(CriaCardAjudaAdicionais());
    // }
    // if (origem == 'DETALHES_CAMINHAO') {
    //   _controllerCardAjuda.add(CriaCardAjudaCaminhaoDetalhes());
    // }
    // if (origem == 'CUSTOS') {
    //   _controllerCardAjuda.add(CriaCardAjudaCustos());
    // }
    // if (origem == 'EMPRESA') {
    //   _controllerCardAjuda.add(CriaCardAjudaEmpresa());
    // }
    // if (origem == 'CONTRATO') {
    //   _controllerCardAjuda.add(CriaCardAjudaContrato());
    // }
    // if (origem == 'CARGA') {
    //   _controllerCardAjuda.add(CriaCardAjudaCarga());
    // }
    // if (origem == 'ROMANEIO') {
    //   _controllerCardAjuda.add(CriaCardAjudaRomaneio());
    // }
  }

  @override
  void dispose() {
    _controllerExibeCard.close();
  }
}

import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/AcessoSistema/Servicos/Autenticacao.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabelaSistemaBloc extends BlocBase {
  var _controllerSelecionaCheckBox = BehaviorSubject<bool>(seedValue: false);

  Stream<bool> get outSelecionaCheckBox => _controllerSelecionaCheckBox.stream;

  final BuildContext contextoAplicacao;

  TabelaSistemaBloc(this.contextoAplicacao);


  Future<void> eventoCliqueCheckBox(
      bool valor) async {
      _controllerSelecionaCheckBox.add(!_controllerSelecionaCheckBox.value);
  }

  @override
  void dispose() {
    _controllerSelecionaCheckBox.close();
  }
}


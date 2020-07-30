import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/screen/visaoGeral.dart';

class AcessoSistemaBloc extends BlocBase {
  var _controllerCarregamento = BehaviorSubject<bool>(seedValue: false);
  var _controllerSelecionaCheckBox = BehaviorSubject<bool>(seedValue: false);

  Stream<bool> get outCarregamento => _controllerCarregamento.stream;
  Stream<bool> get outSelecionaCheckBox => _controllerSelecionaCheckBox.stream;

  final BuildContext contextoAplicacao;

  AcessoSistemaBloc(this.contextoAplicacao);

  Future<void> eventoCliqueBotaoAcesso() async {
    _controllerCarregamento.add(!_controllerCarregamento.value);
    await Future.delayed(Duration(seconds: 2));
    _controllerCarregamento.add(!_controllerCarregamento.value);

    Navigator.of(contextoAplicacao).pushNamed(
      '/VisaoGeral',
    );
  }

  Future<void> eventoCliqueCheckBox(bool valor) async {
    _controllerSelecionaCheckBox.add(!_controllerSelecionaCheckBox.value);
  }

  @override
  void dispose() {
    _controllerCarregamento.close();
  }
}

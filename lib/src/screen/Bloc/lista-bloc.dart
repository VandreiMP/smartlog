import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/AcessoSistema/Servicos/Autenticacao.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListaBloc extends BlocBase {
  var _controllerValorLista = BehaviorSubject<String>();

  Stream<String> get outValorLista => _controllerValorLista.stream;

  final BuildContext contextoAplicacao;

  ListaBloc(this.contextoAplicacao);

  Future<void> eventoCliqueCheckBox(bool valor) async {
    _controllerValorLista.add(_controllerValorLista.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

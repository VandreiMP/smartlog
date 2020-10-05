import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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

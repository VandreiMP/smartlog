import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc extends BlocBase {
  var _controllerRota = BehaviorSubject<bool>();

  Stream<bool> get outRota => _controllerRota.stream;

  // final BuildContext contextoAplicacao;
  // final String rotaFormulario;

  // MenuBloc(this.contextoAplicacao, this.rotaFormulario);

  Future<void> eventoCliquemenu(BuildContext contextoAplicacao, String rotaFormulario) async {
    Navigator.of(contextoAplicacao).pushNamed(rotaFormulario);
    _controllerRota.add(true);
  }

 

  @override
  void dispose() {
    _controllerRota.close();
  }
}

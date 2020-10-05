import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';

class MenuBloc extends BlocBase {
  var _controllerMenu = BehaviorSubject<bool>();

  Stream<bool> get outMenu => _controllerMenu.stream;

  Future<void> eventoCliqueSair(
      BuildContext contextoAplicacao, String rotaFormulario) async {
    final instanciaFirebaseAuth = FirebaseAuth.instance;

    try {
      alertConfirm(
          contextoAplicacao, 'Questionamento', 'Deseja desconectar do sistema?',
          confirmCallback: () {
        instanciaFirebaseAuth.signOut().then((value) =>
            Navigator.of(contextoAplicacao).pushNamed('/AcessoSistema'));
      });
    } catch (on) {
      alert(contextoAplicacao, 'Inconsistência na validação',
          'Erro ao desconectar do sistema!');
    }
  }

  Future<void> eventoCliqueMenu(
      BuildContext contextoAplicacao, String rotaFormulario) async {
    Navigator.of(contextoAplicacao).pushNamed(rotaFormulario);

    if (rotaFormulario == '/ListaFuncionarios') {}
  }

  @override
  void dispose() {
    _controllerMenu.close();
  }
}

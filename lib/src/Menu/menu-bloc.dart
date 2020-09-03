import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';

class MenuBloc extends BlocBase {
  var _controllerMenu = BehaviorSubject<bool>();

  Stream<bool> get outMenu => _controllerMenu.stream;

  // final BuildContext contextoAplicacao;
  // final String rotaFormulario;

  // MenuBloc(this.contextoAplicacao, this.rotaFormulario);

  Future<void> eventoCliqueSair(
      BuildContext contextoAplicacao, String rotaFormulario) async {
    // Navigator.of(contextoAplicacao).pushNamed(rotaFormulario);
    // _controllerRota.add(true);
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
    //UsuarioBloc blocUsuario = BlocProvider.of<UsuarioBloc>(contextoAplicacao);
    Navigator.of(contextoAplicacao).pushNamed(rotaFormulario);
print(rotaFormulario);
    if (rotaFormulario == '/ListaFuncionarios') {
      print('entrou');
     // blocUsuario.consultarDados(contextoAplicacao);
      
    }
  }

  @override
  void dispose() {
    _controllerMenu.close();
  }
}

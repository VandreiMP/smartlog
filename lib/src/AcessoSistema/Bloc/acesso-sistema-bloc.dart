import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/AcessoSistema/Servicos/Autenticacao.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AcessoSistemaBloc extends BlocBase {
  var _controllerSelecionaCheckBox = BehaviorSubject<bool>(seedValue: false);
  var _controllerValidaAcesso = BehaviorSubject<bool>(seedValue: false);

  Stream<bool> get outSelecionaCheckBox => _controllerSelecionaCheckBox.stream;
  Stream<bool> get outValidaAcesso => _controllerValidaAcesso.stream;

  final BuildContext contextoAplicacao;

  AcessoSistemaBloc(this.contextoAplicacao);

  // Future<void> eventoCliqueBotaoAcesso() async {

  //   );
  // }

  Future<void> eventoCliqueCheckBox(
      bool valor, TextEditingController senha) async {
    if (senha.text.isEmpty) {
      _controllerValidaAcesso.add(false);
      alert(contextoAplicacao, 'Alerta de Inconsistência',
          'Para ativar a caixa de seleção, é necessário preencher a senha de acesso ao sistema. Favor verificar!');
    } else {
      _controllerSelecionaCheckBox.add(!_controllerSelecionaCheckBox.value);
    }
  }

  Future<void> validaAcessoUsuario(
      TextEditingController usuario, TextEditingController senha) async {
    usuario.text;
    if (usuario.text.isEmpty || senha.text.isEmpty) {
      _controllerValidaAcesso.add(false);
      alert(contextoAplicacao, 'Inconsistência na validação',
          'Para efetuar o acesso ao sistema é necessário preencher o usuário e a senha. Favor verificar!');
    } else {
      /*
      Autenticação do usuário feita via e-mail e senha que devem criados pelo administrador
      do sistema.
      */

      final instanciaFirebaseAuth = FirebaseAuth.instance;

      /*
      Passa "false" para o último parâmetro da classe de autenticação de modo 
      que só acesse o sistema, caso o usuário seja validado com sucesso pelo Firebase,
      onde o parâmetro será retornado com o valor "true"
      */

      try {
        await instanciaFirebaseAuth
            .signInWithEmailAndPassword(
                email: usuario.text, password: senha.text)
            .then((value) async {
          _controllerValidaAcesso.add(!_controllerValidaAcesso.value);
          await Future.delayed(Duration(seconds: 2));
          _controllerValidaAcesso.add(!_controllerValidaAcesso.value);

          Navigator.of(contextoAplicacao).pushNamed(
            '/VisaoGeral',
          );
        });
      } catch (on) {
        alert(contextoAplicacao, 'Inconsistência na validação',
            'Erro ao efetuar o acesso ao sistema. Favor entrar em contato com o administrador do sistema para conferir suas credenciais de acesso!');
      }

      // AutenticacaoFirebase autenticacaoFirebase = AutenticacaoFirebase(
      //     usuario.text, senha.text, contextoAplicacao, false);

      // if (autenticacaoFirebase.autenticacao == true) {
      //   _controllerValidaAcesso.add(!_controllerValidaAcesso.value);
      //   await Future.delayed(Duration(seconds: 2));
      //   _controllerValidaAcesso.add(!_controllerValidaAcesso.value);

      //   Navigator.of(contextoAplicacao).pushNamed(
      //     '/VisaoGeral',
      //   );
    }
  }

  @override
  void dispose() {
    _controllerValidaAcesso.close();
    _controllerSelecionaCheckBox.close();
  }
}

// }

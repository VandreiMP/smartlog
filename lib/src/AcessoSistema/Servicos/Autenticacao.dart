import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_database/ui/firebase_list.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoFirebase {
  final String usuario;
  final String senha;
  final BuildContext contextoAplicacao;
  bool autenticacao;

  final instanciaFirebaseAuth = FirebaseAuth.instance;

  AutenticacaoFirebase(
    this.usuario,
    this.senha,
    this.contextoAplicacao,
    this.autenticacao,
  );

  Future<void> autenticacaoUsuario() async {
    try {
      await instanciaFirebaseAuth
          .signInWithEmailAndPassword(email: usuario, password: senha)
          .then((value) {
        print(this.autenticacao);
        this.autenticacao = true;
      });
    } catch (on) {
      alert(contextoAplicacao, 'Inconsistência na validação',
          'Erro ao efetuar o acesso ao sistema. Favor entrar em contato com o administrador do sistema para conferir suas credenciais de acesso!');
    }
  }
}

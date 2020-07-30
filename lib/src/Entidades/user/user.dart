import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDao {
  static salvarDados(
    nome,
    id,
    tpUsuario,
    login,
    senha,
    email,
    telefone,
    celular,
    ramal,
  ) {
    Firestore.instance.collection('user').document(id).setData({
      'identificacao': id,
      'nome': nome,
      'tip_usuario': tpUsuario,
      'login': login,
      'senha': senha,
      'e_mail': email,
      'celular': celular,
      'telefone': telefone,
      'ramal': ramal
    });
  }
}

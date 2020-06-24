import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/funcoes/alert.dart';

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
    try {
      Firestore.instance
          .collection('user')
          .document(id)
          .setData({
            'identificacao': id,
            'nome': nome,
            'tip_usuario': tpUsuario,
            'login': login,
            'senha': senha,
            'e_mail': email,
            'celular': celular,
            'telefone': telefone,
            'ramal': ramal
          })
          .then((id) => print('sucesso'))
          .catchError((id) => print('erro'));
    } catch (error) {
      AlertDialog(
        title: Text('Erro'),
        content: Text('Erro ao salvar os dados!'),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {},
          )
        ],
      );
    }
  }
}

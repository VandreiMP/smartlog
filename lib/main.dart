import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/AcessoSistema/Widget/acesso-sistema-widget.dart';
import 'package:smartlogproject/src/funcoes/buscaEmbalagens.dart';
import 'package:smartlogproject/src/screen/screenCarga.dart';
import 'package:smartlogproject/src/screen/screenContrato.dart';
import 'package:smartlogproject/src/screen/screenDespesasContrato.dart';
import 'package:smartlogproject/src/screen/screenManutencao.dart';
import 'package:smartlogproject/src/screen/screenRomaneio.dart';
import 'package:smartlogproject/src/screen/screenAbastecimento.dart';
import 'package:smartlogproject/src/screen/screenTrocaOleo.dart';
import 'package:smartlogproject/src/screen/teste2.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaCustos.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaEmbalagem.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaFuncionario.dart';

import 'src/login/login.dart';
import 'src/screen/screenCaminhao.dart';
import 'src/screen/screenCaminhaoDetalhes.dart';
import 'src/screen/screenCustos.dart';
import 'src/screen/screenEmbalagem.dart';
import 'src/screen/screenEmpresa.dart';
import 'src/screen/screenResponsavelEmpresa.dart';
import 'src/screen/screenUser.dart';
import 'src/screen/visaoGeral.dart';

void main() async => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/AcessoSistema',
      routes: {
        '/AcessoSistema': (context) => AcessoSistemaWidget(),
        '/VisaoGeral': (context) => VisaoGeral(),
        '/ListaFuncionarios': (context) => ListaFuncionarios(),
        '/ListaEmbalagens' : (context) => ListaEmbalagens(),
        '/ListaCustos' : (context) => ListaCustos(),
        '/FormularioUsuario': (context) => ScreenUser(),
        '/FormularioEmbalagem': (context) => ScreenEmbalagem(),
        '/FormularioCaminhao': (context) => ScreenCaminhao(),
        '/FormularioCaminhaoDetalhes': (context) => ScreenCaminhaoDetalhes(),
        '/FormularioCustos': (context) => ScreenCustos(),
        '/FormularioEmpresa': (context) => ScreenEmpresa(),
        '/FormularioEmpresaDetalhes': (context) => ScreenRespEmpresa(),
        '/FormularioContrato': (context) => ScreenContrato(),
        '/FormularioDespesasContrato': (context) => ScreenDespesasContrato(),
        '/FormularioCarga': (context) => ScreenCarga(),
        '/FormularioRomaneio': (context) => ScreenRomaneio(),
        '/FormularioAbastecimento': (context) => ScreenAbastecimento(),
        '/FormularioTrocaDeOleo': (context) => ScreenTrocaOleo(),
        '/FormularioManutencao': (context) => ScreenManutencao(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartlogproject/login/login.dart';
import 'package:smartlogproject/screen/screenAtalhoUser.dart';
import 'package:smartlogproject/screen/screenCaminhao.dart';
import 'package:smartlogproject/screen/screenCaminhaoDetalhes.dart';
import 'package:smartlogproject/screen/screenCustos.dart';
import 'package:smartlogproject/screen/screenEmbalagem.dart';
import 'package:smartlogproject/screen/screenEmpresa.dart';
import 'package:smartlogproject/screen/screenResponsavelEmpresa.dart';
import 'package:smartlogproject/screen/screenUser.dart';
import 'package:smartlogproject/screen/visaoGeral.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/VisaoGeral': (context) => VisaoGeral(),
        '/Atalho': (context) => ScreenAtalhoCadastros(),
        '/FormularioUsuario': (context) => ScreenUser(),
        '/FormularioEmbalagem': (context) => ScreenEmbalagem(),
        '/FormularioCaminhao': (context) => ScreenCaminhao(),
        '/FormularioCaminhaoDetalhes': (context) => ScreenCaminhaoDetalhes(),
        '/FormularioCustos': (context) => ScreenCustos(),
        '/FormularioEmpresa': (context) => ScreenEmpresa(),
        '/FormularioEmpresaDetalhes': (context) => ScreenRespEmpresa(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartlogproject/src/AcessoSistema/Widget/acesso-sistema-widget.dart';
import 'package:smartlogproject/src/screen/screenAjuda.dart';
import 'package:smartlogproject/src/screen/screenCarga.dart';
import 'package:smartlogproject/src/screen/screenManutencao.dart';
import 'package:smartlogproject/src/screen/screenRomaneio.dart';
import 'package:smartlogproject/src/util/Listas%20de%20Valores/criaListaValoresCaminhao.dart';
import 'package:smartlogproject/src/util/Listas%20de%20Valores/criaListaValoresCusto.dart';
import 'package:smartlogproject/src/util/Listas%20de%20Valores/criaListaValoresEmbalagem.dart';
import 'package:smartlogproject/src/util/Listas%20de%20Valores/criaListaValoresMotorista.dart';
import 'src/screen/screenAbastecimento.dart';
import 'package:smartlogproject/src/screen/screenTrocaOleo.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaAbastecimento.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaCaminhao.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaCarregamentoMercadoria.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaCustos.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaEmbalagem.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaEmpresa.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaFuncionario.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaManutencao.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaTrocaOleo.dart';
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
        /*
        Acesso e Visão Geral
        */
        '/AcessoSistema': (context) => AcessoSistemaWidget(),
        '/VisaoGeral': (context) => VisaoGeral(),
        /*
        Listas de Registros
        */
        '/ListaFuncionarios': (context) => ListaFuncionarios(),
        '/ListaEmbalagens': (context) => ListaEmbalagens(),
        '/ListaEmpresas': (context) => ListaEmpresas(),
        '/ListaCustos': (context) => ListaCustos(),
        '/ListaCaminhoes': (context) => ListaCaminhoes(),
        '/ListaCargas': (context) => ListaCargas(),
        '/ListaAbastecimentos': (context) => ListaAbastecimentos(),
        '/ListaTrocaOleo': (context) => ListaTrocaOleo(),
        '/ListaManutencao': (context) => ListaManutencao(),
        /*
        Formulários Detalhados
        */
        '/FormularioUsuario': (context) => ScreenUser(),
        '/FormularioEmbalagem': (context) => ScreenEmbalagem(),
        '/FormularioCaminhao': (context) => ScreenCaminhao(),
        '/FormularioCaminhaoDetalhes': (context) => ScreenCaminhaoDetalhes(),
        '/FormularioCustos': (context) => ScreenCustos(),
        '/FormularioEmpresa': (context) => ScreenEmpresa(),
        '/FormularioEmpresaDetalhes': (context) => ScreenRespEmpresa(),
        '/FormularioCarga': (context) => ScreenCarga(),
        '/FormularioRomaneio': (context) => ScreenRomaneio(),
        '/FormularioAbastecimento': (context) => ScreenAbastecimento(),
        '/FormularioTrocaDeOleo': (context) => ScreenTrocaOleo(),
        '/FormularioManutencao': (context) => ScreenManutencao(),
        /*
        Tela de ajuda
        */
        '/TelaAjuda': (context) => ScreenAjuda(),
        /*
        Listas de Valores p/ Formulários
        */
        '/ListaValoresEmbalagem': (context) => ListaValoresEmbalagem(),
        '/ListaValoresCusto': (context) => ListaValoresCusto(),
        '/ListaValoresCaminhao': (context) => ListaValoresCaminhao(0),
        '/ListaValoresMotorista': (context) => ListaValoresMotorista()
      },
    );
  }
}

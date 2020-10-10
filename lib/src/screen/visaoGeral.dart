import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20Auxiliares/legendaDashBoard.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresAbastecimento.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresCarga.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresCustosporSolic.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresManutencao.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresTrocaOleo.dart';
import 'package:smartlogproject/src/tabelas/Widget/tabelaCarregamentoMercadoria.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'screenPattern.dart';

class VisaoGeral extends StatefulWidget {
  @override
  _VisaoGeralState createState() => _VisaoGeralState();
}

class _VisaoGeralState extends State<VisaoGeral> {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Widget dashBoardCargas;
  bool exibeDashBoardCargas = false;
  String labelBotao = 'Exibir Cargas';
  double larguraBotao = 120;
  String origem = 'PROG';
  @override
  Widget build(BuildContext context) {
    return Scroll(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dashBoardCargas = ListaValoresCarga();
                          exibeDashBoardCargas = !exibeDashBoardCargas;

                          if (exibeDashBoardCargas == true) {
                            labelBotao = 'Exibir Programações';
                            larguraBotao = 170;
                            origem = 'CARGA';
                          } else {
                            labelBotao = 'Exibir Cargas';
                            larguraBotao = 120;
                            origem = 'PROG';
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: larguraBotao,
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                            ),
                            child: Text(
                              labelBotao,
                              style: TextStyle(
                                  fontFamily: 'Cardo',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                    LegendaDashBoard(origem),
                  ],
                ),
                Scroll(
                  child: exibeDashBoardCargas == true
                      ? dashBoardCargas
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListaValoresAbastecimento(),
                            ListaValoresManutencao(),
                            ListaValoresTrocadeOleo(),
                          ],
                        ),
                ),
              ]),
        ],
      ),
    );
  }
}

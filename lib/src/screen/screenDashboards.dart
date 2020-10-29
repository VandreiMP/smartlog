import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresAbastecimento.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresCarga.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresCustosporSolic.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresManutencao.dart';
import 'package:smartlogproject/src/DashBoard/Componentes%20de%20Lista/criaListaValoresTrocaOleo.dart';
import 'screenPattern.dart';

class Dashboards extends StatefulWidget {
  @override
  _DashboardsState createState() => _DashboardsState();
}

class _DashboardsState extends State<Dashboards> {
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
  Widget dashBoard;
  bool exibeDashBoard = false;
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
                          exibeDashBoard = true;
                          dashBoard = ListaValoresCustoProg();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                            ),
                            child: Text(
                              'Consultar Manutenções',
                              style: TextStyle(
                                  fontFamily: 'Cardo',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
                Scroll(child: exibeDashBoard == true ? dashBoard : null),
              ]),
        ],
      ),
    );
  }
}

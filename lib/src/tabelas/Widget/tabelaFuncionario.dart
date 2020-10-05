import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';
import 'package:smartlogproject/src/util/Componentes/requiredLabel.dart';
import 'package:smartlogproject/src/screen/screenPattern.dart';
import 'package:smartlogproject/src/util/M%C3%A9todos%20de%20Busca/buscaFuncionarios.dart';

class ListaFuncionarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child:
          BlocProvider(bloc: UsuarioBloc(context), child: CriaCardFormulario()),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  List<String> usuarios = [
    'Funcionário',
    'Diretor',
    'Motorista',
  ];

  @override
  Widget build(BuildContext context) {
    return Scroll(
      height: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 2.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: new Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/VisaoGeral');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.0),
                                  ),
                                ),
                                child: Icon(
                                  Icons.home,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/FormularioUsuario',
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: AppText(
                        'Lista de Funcionários',
                        bold: true,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        BuscaFuncionarios(Icons.search, () {
                          Navigator.of(context).pushNamed(
                            '/FormularioUsuario',
                          );
                        }, null)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      
      ),
    );
  }

}

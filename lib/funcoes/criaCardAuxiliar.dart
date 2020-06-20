import 'package:flutter/material.dart';
import 'package:smartlogproject/funcoes/criaCardAjuda.dart';
import 'package:smartlogproject/funcoes/criaCardAjudaAdicionais.dart';
import 'package:smartlogproject/funcoes/criaCardAjudaCustos.dart';
import 'package:smartlogproject/funcoes/criaCardAjudaDetalhes.dart';
import 'package:smartlogproject/funcoes/criaCardAjudaEmpresa.dart';
import 'package:smartlogproject/screen/screenUser.dart';

class CriaCardAuxiliar extends StatefulWidget {
  final String caminhoImagem;
  final String nomeFormulario;
  final String origem;

  const CriaCardAuxiliar(
      {this.caminhoImagem, this.nomeFormulario, this.origem});

  @override
  _CriaCardAuxiliarState createState() => _CriaCardAuxiliarState();
}

class _CriaCardAuxiliarState extends State<CriaCardAuxiliar> {
  bool selected = false;
  Widget card;
  String route;

  @override
  Widget build(BuildContext context) {
    if (widget.origem == 'GERAL') {
      card = CriaCardAjuda();
      route = '/VisaoGeral';
    }
    if (widget.origem == 'ADICIONAIS') {
      card = CriaCardAjudaAdicionais();
      route = '/VisaoGeral';
    }
    if (widget.origem == 'DETALHES_CAMINHAO') {
      card = CriaCardAjudaCaminhaoDetalhes();
      route = '/FormularioCaminhao';
    }
    if (widget.origem == 'CUSTOS') {
      card = CriaCardAjudaCustos();
      route = '/VisaoGeral';
    }
     if (widget.origem == 'EMPRESA') {
      card = CriaCardAjudaEmpresa();
      route = '/VisaoGeral';
    }
    if (widget.origem == 'RESPONSAVEL') {
      card = CriaCardAjuda();
      route = '/FormularioEmpresa';
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Card(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: new Border.all(
                  color: Colors.black,
                ),
              ),
              padding: EdgeInsets.all(16),
              height: 320,
              width: 320,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 200, maxHeight: 200),
                        child: Image.asset(widget.caminhoImagem),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.nomeFormulario,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(route);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.0),
                                  ),
                                ),
                                child: Icon(
                                  Icons.save,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/VisaoGeral');
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
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScreenUser(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(2.0),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      //aqui deve esconder o card de ajuda
                                      selected = !selected;
                                    });
                                  },
                                  child: Icon(
                                    Icons.help,
                                    size: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(height: selected ? null : 0, child: card),
      ],
    );
  }
}

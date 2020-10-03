import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Cards/Bloc/card-ajuda-bloc.dart';
import '../../screen/screenUser.dart';

class CriaCardAuxiliar extends StatelessWidget {
  final String caminhoImagem;
  final String nomeFormulario;
  final String origem;
  final String origemDado;
  final String chaveConsulta;

  const CriaCardAuxiliar(
      {Key key,
      this.caminhoImagem,
      this.nomeFormulario,
      this.origem,
      this.origemDado,
      this.chaveConsulta})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardAjudaBloc>(
      bloc: CardAjudaBloc(context, origem, origemDado, chaveConsulta),
      child: CardAjuda(
          caminhoImagem, nomeFormulario, origem, origemDado, chaveConsulta),
    );
  }
}

class CardAjuda extends StatelessWidget {
  bool selected = false;
  Widget card;
  String route;
  final String caminhoImagem;
  final String nomeFormulario;
  final String origem;
  final String origemDado;
  final String chaveConsulta;

  CardAjuda(this.caminhoImagem, this.nomeFormulario, this.origem,
      this.origemDado, this.chaveConsulta);
  @override
  Widget build(BuildContext context) {
    CardAjudaBloc blocAjuda = BlocProvider.of<CardAjudaBloc>(context);

    return StreamBuilder<CardAjudaBloc>(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                  height: 340,
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
                            child: Image.asset(caminhoImagem),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            nomeFormulario,
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
                                      if (origem == 'CARGA') {
                                        Navigator.of(context).pushNamed(
                                          '/ListaCargas',
                                        );
                                      } else if (origem == 'EMPRESA') {
                                        Navigator.of(context).pushNamed(
                                          '/ListaEmpresas',
                                        );
                                      } else if (origem == 'RESPONSAVEL') {
                                        Navigator.of(context).pushNamed(
                                            '/FormularioEmpresa',
                                            arguments: chaveConsulta);
                                      } else if (origem == 'EMBALAGEM') {
                                        Navigator.of(context).pushNamed(
                                          '/ListaEmbalagens',
                                        );
                                      } else if (origem == 'CUSTOS') {
                                        Navigator.of(context).pushNamed(
                                          '/ListaCustos',
                                        );
                                      } else if (origem == 'USUARIO') {
                                        Navigator.of(context).pushNamed(
                                          '/ListaFuncionarios',
                                        );
                                      } else if (origem == 'CAMINHAO') {
                                        Navigator.of(context).pushNamed(
                                          '/ListaCaminhoes',
                                        );
                                      } else if (origem ==
                                          'DETALHES_CAMINHAO') {
                                        Navigator.of(context).pushNamed(
                                            '/FormularioCaminhao',
                                            arguments: chaveConsulta);
                                      } else if (origem == 'COMBUSTIVEL') {
                                        Navigator.of(context).pushNamed(
                                            '/ListaAbastecimentos',
                                            arguments: chaveConsulta);
                                      } else if (origem == 'MANUTENCAO') {
                                        Navigator.of(context).pushNamed(
                                            '/ListaManutencao',
                                            arguments: chaveConsulta);
                                      } else if (origem == 'OLEO') {
                                        Navigator.of(context).pushNamed(
                                            '/ListaTrocaOleo',
                                            arguments: chaveConsulta);
                                      } else if (origem == 'ROMANEIO') {
                                        Navigator.pop(context);
                                      }
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
                                onTap: () {
                                  blocAjuda.eventoCliqueBotaoSalvar();
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
                                      // onTap: () {
                                      //   blocAjuda.eventoCliqueBotaoAjuda();

                                      //   selected = snapshot.data;
                                      // },
                                      child: Icon(
                                        Icons.help,
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
                                        blocAjuda
                                            .eventoCliqueBotaoApagarDados();

                                        selected = snapshot.data;
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
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
            Container(height: selected ? null : 0, child: snapshot.data),
          ],
        );
      },
    );
  }
}

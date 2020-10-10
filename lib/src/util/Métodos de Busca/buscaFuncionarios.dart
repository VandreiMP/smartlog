import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';

class BuscaFuncionarios extends StatefulWidget {
  final IconData iconeLista;
  final Function funcaoLista;
  final String origem;

  const BuscaFuncionarios(
    this.iconeLista,
    this.funcaoLista,
    this.origem,
  );

  @override
  _BuscaFuncionariosState createState() => _BuscaFuncionariosState(
        iconeLista,
        funcaoLista,
        origem,
      );
}

class _BuscaFuncionariosState extends State<BuscaFuncionarios> {
  final IconData iconeLista;
  final Function funcaoLista;
  final String origem;

  _BuscaFuncionariosState(
    this.iconeLista,
    this.funcaoLista,
    this.origem,
  );
  @override
  Widget build(BuildContext context) {
    UsuarioBloc blocUsuario = BlocProvider.of<UsuarioBloc>(context);
    final Firestore firestore = Firestore.instance;
    return Row(
      children: [
        Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("usuario")
                  .orderBy("nome", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Consultando registros existentes...',
                        style: TextStyle(
                            fontFamily: 'Cardo',
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ));

                final int funcionarioContador = snapshot.data.documents.length;
                if (funcionarioContador > 0) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: new Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 108.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Identificação',
                                bold: true,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: AppText(
                                  'Nome',
                                  bold: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              alignment: Alignment.topLeft,
                              width: 670,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: funcionarioContador,
                                itemBuilder: (BuildContext context, int index) {
                                  final DocumentSnapshot document =
                                      snapshot.data.documents[index];
                                  final dynamic nome = document['nome'];
                                  final dynamic identificacao =
                                      document['identificacao'];
                                  final dynamic tipoFuncionario =
                                      document['tipoUsuario'];
                                  return Container(
                                    child: origem != 'CARGA' ||
                                            (tipoFuncionario == 'Motorista' &&
                                                origem == 'CARGA')
                                        ? Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Container(
                                                  alignment: Alignment.topRight,
                                                  padding: EdgeInsets.all(10),
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    border: new Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    identificacao.toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Cardo',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  width: 400,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                    border: new Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    nome,
                                                    style: TextStyle(
                                                      fontFamily: 'Cardo',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  if (origem == 'CARGA') {
                                                    Navigator.pop(
                                                        context, identificacao);
                                                  } else {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      '/FormularioUsuario',
                                                      arguments: identificacao,
                                                    );
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 7.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[900],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2.0),
                                                      ),
                                                    ),
                                                    child: Icon(
                                                      iconeLista,
                                                      size: 30.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          )
                                        : null,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Não há nenhum registro salvo no banco de dados.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

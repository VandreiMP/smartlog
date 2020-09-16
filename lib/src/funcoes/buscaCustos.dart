import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/funcoes/appText.dart';

class BuscaCustos extends StatefulWidget {
  final IconData iconeLista;
  final Function funcaoLista;

  const BuscaCustos(this.iconeLista, this.funcaoLista);

  @override
  _BuscaCustosState createState() => _BuscaCustosState(iconeLista, funcaoLista);
}

class _BuscaCustosState extends State<BuscaCustos> {
  final IconData iconeLista;
  final Function funcaoLista;

  _BuscaCustosState(this.iconeLista, this.funcaoLista);
  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    return Row(
      children: [
        Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("custos")
                  .orderBy("identificacao", descending: false)
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
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ));

                final int embalagemContador = snapshot.data.documents.length;
                print(embalagemContador);
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
                        padding: const EdgeInsets.only(left: 111.0, top: 15),
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
                                'Detalhes',
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
                              itemCount: embalagemContador,
                              itemBuilder: (BuildContext context, int index) {
                                final DocumentSnapshot document =
                                    snapshot.data.documents[index];
                                final dynamic descricao = document['detalhes'];
                                final dynamic identificacao =
                                    document['identificacao'];
                                return Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          padding: EdgeInsets.all(10),
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: new Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Text(identificacao.toString()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: 400,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            border: new Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: Text(descricao.toString()),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          funcaoLista();
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blue[900],
                                              borderRadius: BorderRadius.all(
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

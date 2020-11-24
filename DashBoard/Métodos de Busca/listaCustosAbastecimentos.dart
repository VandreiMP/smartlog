import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';

class DashBoardCustosAbastecimento extends StatefulWidget {
  @override
  _DashBoardCustosAbastecimentoState createState() =>
      _DashBoardCustosAbastecimentoState();
}

class _DashBoardCustosAbastecimentoState extends State<DashBoardCustosAbastecimento> {
  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    String filtro = 'Aberta';
    return Scroll(
      //   height: 155,
      child: Row(
        children: [
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection("solicitacaoAbastecimento")
                    .orderBy("identificacao", descending: true)
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
                          'Consultando programações efetivadas...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ));

                  final int abastecimentoContador =
                      snapshot.data.documents.length;

                  if (abastecimentoContador > 0) {
                    double somaCustos = 0.00;
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 15),
                                alignment: Alignment.topLeft,
                                width: 805,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: abastecimentoContador,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final DocumentSnapshot document =
                                          snapshot.data.documents[index];

                                      somaCustos =
                                          somaCustos + document['custoTotal'];

                                      String situacao =
                                          (document['situacaoSolicitacao']);

                                      return Container(
                                        child: situacao == 'Efetivada' &&
                                                (index + 1 ==
                                                    abastecimentoContador)
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Custos com abastecimento',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(1.0),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          width: 600,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            somaCustos
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .blueGrey[
                                                                    900]),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    width: 800,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              )
                                            : null,
                                      );
                                    }),
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
                              'Você não possui nenhuma programação para manutenção registrada no sistema.',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


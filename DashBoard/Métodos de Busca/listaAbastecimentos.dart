import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';

class DashBoardAbastecimento extends StatefulWidget {
  @override
  _DashBoardAbastecimentoState createState() => _DashBoardAbastecimentoState();
}

class _DashBoardAbastecimentoState extends State<DashBoardAbastecimento> {
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
                    .orderBy("prioridade")
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
                          'Consultando programações pendentes...',
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

                  final int abastecimentoContador =
                      snapshot.data.documents.length;
                  if (abastecimentoContador > 0) {
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
                                    final dynamic detalhes =
                                        document['detalhes'];
                                    final dynamic identificacao =
                                        document['identificacao'];

                                    final dynamic prioridade =
                                        document['prioridade'];
                                    Color corFila;

                                    if (prioridade == 1) {
                                      corFila = Colors.red;
                                    } else if (prioridade == 2) {
                                      corFila = Colors.yellow;
                                    } else if (prioridade == 3) {
                                      corFila = Colors.green;
                                    }

                                    String situacao =
                                        (document['situacaoSolicitacao']);

                                    String dataAbertura =
                                        document.data['dataAbertura'];

                                    return Container(
                                      child: situacao == 'Aberta'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 6,
                                                      decoration: BoxDecoration(
                                                        color: corFila,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    2)),
                                                        border: new Border.all(
                                                          color: corFila,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        width: 600,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Text(
                                                          
                                                          detalhes
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            fontFamily: 'Cardo',
                                                            fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                      .blueGrey[
                                                                  900]),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Data Abertura',
                                                            style: TextStyle(
                                                              fontFamily: 'Cardo',
                                                              fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                        .black),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              dataAbertura
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontFamily: 'Cardo',
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                          .blueGrey[
                                                                      900]),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await Navigator.of(
                                                                context)
                                                            .pushNamed(
                                                                '/FormularioAbastecimento',
                                                                arguments:
                                                                    identificacao);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 1.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  2.0),
                                                            ),
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 15.0,
                                                            color: Colors.grey,
                                                          ),
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
                                          // : abastecimentoContador == index + 1
                                          //     ? Container(
                                          //         child: Column(
                                          //           crossAxisAlignment:
                                          //               CrossAxisAlignment
                                          //                   .start,
                                          //           children: [
                                          //             Padding(
                                          //               padding:
                                          //                   const EdgeInsets
                                          //                       .only(top: 2),
                                          //               child: Text(
                                          //                 'Você não possui nenhuma programação em aberto para abastecimento.',
                                          //                 style: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .bold,
                                          //                     fontSize: 15,
                                          //                     color:
                                          //                         Colors.black),
                                          //               ),
                                          //             ),
                                          //             SizedBox(height: 15),
                                          //           ],
                                          //         ),
                                          //       )
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
                              'Você não possui nenhuma programação para abastecimento registrada no sistema.',
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

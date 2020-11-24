import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';

class DashBoardCarga extends StatefulWidget {
  @override
  _DashBoardCargaState createState() => _DashBoardCargaState();
}

class _DashBoardCargaState extends State<DashBoardCarga> {
  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    String filtro = 'Aberta';
    return Scroll(
      child: Row(
        children: [
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection("carregamentoMercadoria")
                    .orderBy("carga")
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
                          'Consultando cargas pendentes...',
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

                  final int cargaContador = snapshot.data.documents.length;
                  print(cargaContador);
                  if (cargaContador > 0) {
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
                                  itemCount: cargaContador,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final DocumentSnapshot document =
                                        snapshot.data.documents[index];
                                    final dynamic dataEntrega =
                                        document['dataEntrega'];
                                    final dynamic comprador =
                                        document['comprador'];
                                    final dynamic numerocarga =
                                        document.data['carga'];

                                    Color corFila;
                                    String situacao =
                                        (document['situacaoExpedicao']);

                                    if (situacao == 'Montagem da Carga') {
                                      corFila = Colors.red;
                                    } else if (situacao == 'Em Trânsito') {
                                      corFila = Colors.green;
                                    }

                                    return Container(
                                      child: situacao == 'Montagem da Carga' ||
                                              situacao == 'Em Trânsito'
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
                                                          comprador
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cardo',
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
                                                            'Data Entrega',
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
                                                              dataEntrega
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
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                '/FormularioCarga',
                                                                arguments:
                                                                    numerocarga);
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
                                          // : cargaContador == index + 1
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
                                          //                 'Você não possui nenhuma carga em aberto ou em trânsito.',
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
                              'Você não possui nenhuma carga registrada no sistema.',
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

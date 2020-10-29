import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';

class BuscaManutencao extends StatefulWidget {
  @override
  _BuscaManutencaoState createState() => _BuscaManutencaoState();
}

class _BuscaManutencaoState extends State<BuscaManutencao> {
  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    return Row(
      children: [
        Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("solicitacaoManutencao")
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

                final int manutencaoContador = snapshot.data.documents.length;
                if (manutencaoContador > 0) {
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
                          padding: const EdgeInsets.only(left: 124.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 23.0),
                                child: AppText(
                                  'Código',
                                  bold: true,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: AppText(
                                  'Detalhes',
                                  bold: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 485.0),
                                child: AppText(
                                  'Custo Total',
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
                              width: 925,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: manutencaoContador,
                                itemBuilder: (BuildContext context, int index) {
                                  final DocumentSnapshot document =
                                      snapshot.data.documents[index];
                                  final dynamic detalhes = document['detalhes'];
                                  final dynamic identificacao =
                                      document['identificacao'];
                                  final dynamic custoTotal =
                                      document['custoTotal'];

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
                                            child: Text(
                                              identificacao,
                                              style: TextStyle(
                                                fontFamily: 'Cardo',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            padding: EdgeInsets.all(10),
                                            width: 500,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: new Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Text(
                                              detalhes,
                                              style: TextStyle(
                                                fontFamily: 'Cardo',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            padding: EdgeInsets.all(10),
                                            width: 150,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              border: new Border.all(
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Text(
                                              document['custoTotal'] != null
                                                  ? custoTotal.toString()
                                                  : '0.00',
                                              style: TextStyle(
                                                fontFamily: 'Cardo',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                '/FormularioManutencao',
                                                arguments: identificacao);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 7.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue[900],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(2.0),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.search,
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
                } else {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Não há nenhum registro gravado no sistema.',
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

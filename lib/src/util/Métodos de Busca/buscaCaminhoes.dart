import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/constantes/mensagens.dart';
import 'package:smartlogproject/src/util/Componentes/alert.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';

class BuscaCaminhao extends StatefulWidget {
  final IconData iconeLista;
  final Function funcaoLista;
  final String origem;
  final double pesoCarregado;

  const BuscaCaminhao(
      this.iconeLista, this.funcaoLista, this.origem, this.pesoCarregado);
  @override
  _BuscaCaminhaoState createState() =>
      _BuscaCaminhaoState(iconeLista, funcaoLista, origem, pesoCarregado);
}

class _BuscaCaminhaoState extends State<BuscaCaminhao> {
  final IconData iconeLista;
  final Function funcaoLista;
  final String origem;
  final double pesoCarregado;

  _BuscaCaminhaoState(
      this.iconeLista, this.funcaoLista, this.origem, this.pesoCarregado);
  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    return Row(
      children: [
        Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("caminhao")
                  .orderBy("descricao", descending: false)
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

                final int caminhaoContador = snapshot.data.documents.length;
                if (caminhaoContador > 0) {
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
                          padding: const EdgeInsets.only(left: 165.0, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                'Placa',
                                bold: true,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0),
                                child: AppText(
                                  'Decrição',
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
                                itemCount: caminhaoContador,
                                itemBuilder: (BuildContext context, int index) {
                                  final DocumentSnapshot document =
                                      snapshot.data.documents[index];

                                  final dynamic descricao =
                                      document['descricao'];

                                  final dynamic placa = document['placa'];
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
                                            child: Text(
                                              placa.toString(),
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
                                            child: Text(
                                              descricao.toString(),
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
                                              print(pesoCarregado);
                                              if (pesoCarregado != null) {
                                                Firestore.instance
                                                    .collection("fichaCaminhao")
                                                    .document(identificacao)
                                                    .get()
                                                    .then((coluna) async => coluna
                                                                        .data[
                                                                    'capacidadeCarga'] !=
                                                                null &&
                                                                coluna.data[
                                                                    'capacidadeCarga'] > 0
                                                                    &&
                                                            coluna.data[
                                                                    'capacidadeCarga'] <
                                                                pesoCarregado
                                                        ? alert(
                                                            context,
                                                            mensagemAlerta,
                                                            'O peso carregado excede a capacidade máxima do caminhão!')
                                                        : Navigator.pop(context,
                                                            identificacao));
                                              } else {
                                                Navigator.pop(
                                                    context, identificacao);
                                              }
                                            } else {
                                              Navigator.of(context).pushNamed(
                                                  '/FormularioCaminhao',
                                                  arguments: identificacao);
                                            }
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

import 'package:flutter/material.dart';
import 'package:smartlogproject/src/util/Componentes/appText.dart';

class LegendaDashBoard extends StatelessWidget {
  final String origem;

  const LegendaDashBoard(this.origem);

  @override
  Widget build(BuildContext context) {
    if (origem == 'PROG') {
      return Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 5),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    border: new Border.all(
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: AppText(
                    'Prioridade Alta',
                    bold: true,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 30,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    border: new Border.all(
                      color: Colors.yellow,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: AppText(
                    'Prioridade Média',
                    bold: true,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 30,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    border: new Border.all(
                      color: Colors.green,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: AppText(
                    'Prioridade Baixa',
                    bold: true,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    } else if (origem == 'CARGA') {
      return Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 5),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    border: new Border.all(
                      color: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: AppText(
                    'Carga em expedição',
                    bold: true,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 30,
                  width: 6,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    border: new Border.all(
                      color: Colors.green,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: AppText(
                    'Carga em trânsito',
                    bold: true,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }
  }
}

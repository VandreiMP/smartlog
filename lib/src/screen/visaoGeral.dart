import 'package:flutter/material.dart';
import 'screenPattern.dart';

class VisaoGeral extends StatefulWidget {
  @override
  _VisaoGeralState createState() => _VisaoGeralState();
}

class _VisaoGeralState extends State<VisaoGeral> {
  @override
  Widget build(BuildContext context) {
    //  print('validaAcessoUsuario()');
    // validaAcessoUsuario().then((retornoValidacao) => print('retorno: $retornoValidacao'));

    return ScreenPattern(
      child: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1165,
      alignment: Alignment.center,
      child: Card(
        //margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: new Border.all(
              color: Colors.black,
            ),
          ),
          // padding: EdgeInsets.all(16),
          //height: 500,
          // width: 1000,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //padding: const EdgeInsets.all(4.0),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxWidth: 15000, maxHeight: 500),
                    child: Image.asset(
                      'Images/fundosistema.png',
                      width: 700,
                      height: 500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Gerencie de forma estratégica a sua frota e reduza custos com atrasos na entrega',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

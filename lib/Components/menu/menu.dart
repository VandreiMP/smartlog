import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartlogproject/Components/menu/itemMenu.dart';

class Menu extends StatefulWidget {
  const Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 250,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ItemMenu(
              icon: FontAwesomeIcons.truck,
              title: 'Frota',
              onPress: () {
                print('Cliquei frota');
              },
            ),
            ItemMenu(
              icon: FontAwesomeIcons.moneyBill,
              title: 'Entrega',
              onPress: () {
                print('Cliquei parâmetros');
              },
            )
          ],
        ),
    );
  }
}

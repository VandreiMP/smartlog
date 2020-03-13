import 'package:flutter/material.dart';
import 'package:smartlogproject/Components/menu/itemMenu.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ItemMenu(
            icon: Icons.content_paste,
            title: 'Frota',
            onPress: () {
            },
            arrowIcon: Icons.arrow_forward_ios,
          ),
          ItemMenu(
            icon: Icons.shop_two,
            title: 'Pedidos',
            onPress: () {
              print('Cliquei pedidos');
            },
            arrowIcon: Icons.arrow_forward_ios,
          ),
          ItemMenu(
            icon: Icons.local_shipping,
            title: 'Carga',
            onPress: () {
              print('Cliquei carga');
            },
            arrowIcon: Icons.arrow_forward_ios,
          ),
          ItemMenu(
            icon: Icons.map,
            title: 'Rotas',
            onPress: () {
              print('Cliquei rotas');
            },
            arrowIcon: Icons.arrow_forward_ios,
          ),
          ItemMenu(
            icon: Icons.info,
            title: 'Relatórios',
            onPress: () {
              print('Cliquei relatórios');
            },
            arrowIcon: Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}

  /*void clickButton (){
    setState(() {
      shape = RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red));
    });
  }*/


import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Menu/menu-bloc.dart';

import '../scroll/scroll.dart';
import 'itemMenu.dart';
import 'subMenu.dart';

class Menu extends StatelessWidget {
  Widget build(BuildContext context) {
    /// MenuBloc blocMenu = BlocProvider.of<MenuBloc>(context);
    return BlocProvider<MenuBloc>(
      bloc: MenuBloc(),
      child: Scroll(
        color: Colors.white,
        height: double.infinity,
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ItemMenu(
                icon: Icons.content_paste,
                title: 'Cadastros',
                onPress: () {},
                subMenu: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300], width: 1),
                        ),
                      ),
                      child: SubMenu(
                        title: 'Empresa',
                        onPress: () {
                          Navigator.of(context).pushNamed('/FormularioEmpresa');
                        },
                        arrowIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300], width: 1),
                        ),
                      ),
                      child: SubMenu(
                        title: 'Usuário',
                        onPress: () {
                          Navigator.of(context).pushNamed('/FormularioUsuario');
                          // Navigator.of(context).pushNamed('/ListaUsuario');
                        },
                        arrowIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300], width: 1),
                        ),
                      ),
                      child: SubMenu(
                        title: 'Embalagem',
                        onPress: () {
                          Navigator.of(context)
                              .pushNamed('/FormularioEmbalagem');
                        },
                        arrowIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey[300], width: 1)),
                      ),
                      child: SubMenu(
                        title: 'Frota',
                        onPress: () {
                          Navigator.of(context)
                              .pushNamed('/FormularioCaminhao');
                        },
                        arrowIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                    Container(
                      child: SubMenu(
                        title: 'Custos',
                        onPress: () {
                          Navigator.of(context).pushNamed('/FormularioCustos');
                        },
                        arrowIcon: Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                ),
                arrowIcon: Icons.arrow_forward_ios,
                colorMenu: Colors.blueGrey[600],
                colorMenuSelected: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            ItemMenu(
              icon: Icons.shopping_cart,
              title: 'Contratos',
              onPress: () {
                // blocMenu.eventoCliquemenu(context, '/FormularioContrato');
              },
              arrowIcon: Icons.arrow_forward_ios,
              colorMenu: Colors.blueGrey[600],
              colorMenuSelected: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            ItemMenu(
              icon: Icons.local_shipping,
              title: 'Carga',
              onPress: () {
                Navigator.of(context).pushNamed('/FormularioCarga');
              },
              arrowIcon: Icons.arrow_forward_ios,
              colorMenu: Colors.blueGrey[600],
              colorMenuSelected: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            // ItemMenu(
            //   icon: Icons.map,
            //   title: 'Rotas',
            //   onPress: () {
            //     print('Cliquei rotas');
            //   },
            //   arrowIcon: Icons.arrow_forward_ios,
            //   colorMenu: Colors.blueGrey[600],
            //   colorMenuSelected: Colors.white,
            //   fontWeight: FontWeight.normal,
            // ),
            ItemMenu(
              icon: Icons.trending_up,
              title: 'Relatórios',
              onPress: () {
                print('Relatórios');
              },
              arrowIcon: Icons.arrow_forward_ios,
              colorMenu: Colors.blueGrey[600],
              colorMenuSelected: Colors.white,
              fontWeight: FontWeight.normal,
            ),
            ItemMenu(
              icon: Icons.info,
              title: 'Info',
              onPress: () {
                print('Info');
              },
              arrowIcon: Icons.arrow_forward_ios,
              colorMenu: Colors.blueGrey[600],
              colorMenuSelected: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
      ),
    );
  }
}

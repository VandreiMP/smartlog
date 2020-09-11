import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartlogproject/src/Menu/menu-bloc.dart';

import '../scroll/scroll.dart';
import 'itemMenu.dart';
import 'subMenu.dart';

class Menu extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider<MenuBloc>(
      bloc: MenuBloc(),
      child: ConstroiMenu(),
    );
  }
}

class ConstroiMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MenuBloc blocMenu = BlocProvider.of<MenuBloc>(context);
    return Scroll(
      color: Colors.white,
      height: double.infinity,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<Object>(
              stream: blocMenu.outMenu,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Center(
                  child: ItemMenu(
                    icon: Icons.content_paste,
                    title: 'Cadastros',
                    onPress: () {},
                    subMenu: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey[300], width: 1),
                            ),
                          ),
                          child: SubMenu(
                            title: 'Empresa',
                            onPress: () {
                              Navigator.of(context).pushNamed('/ListaEmpresas');
                            },
                            arrowIcon: Icons.arrow_forward_ios,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey[300], width: 1),
                            ),
                          ),
                          child: SubMenu(
                            title: 'Usuário',
                            onPress: () {
                              blocMenu.eventoCliqueMenu(
                                  context, '/ListaFuncionarios');
                            },
                            arrowIcon: Icons.arrow_forward_ios,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey[300], width: 1),
                            ),
                          ),
                          child: SubMenu(
                            title: 'Embalagem',
                            onPress: () {
                              blocMenu.eventoCliqueMenu(
                                  context, '/ListaEmbalagens');
                            },
                            arrowIcon: Icons.arrow_forward_ios,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[300], width: 1)),
                          ),
                          child: SubMenu(
                            title: 'Frota',
                            onPress: () {
                              Navigator.of(context)
                                  .pushNamed('/ListaCaminhoes');
                            },
                            arrowIcon: Icons.arrow_forward_ios,
                          ),
                        ),
                        Container(
                          child: SubMenu(
                            title: 'Custos',
                            onPress: () {
                              Navigator.of(context).pushNamed('/ListaCustos');
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
                );
              }),
          ItemMenu(
            icon: Icons.local_shipping,
            title: 'Carga',
            onPress: () {
              Navigator.of(context).pushNamed('/ListaCargas');
            },
            arrowIcon: Icons.arrow_forward_ios,
            colorMenu: Colors.blueGrey[600],
            colorMenuSelected: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          StreamBuilder<Object>(
              stream: blocMenu.outMenu,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Center(
                  child: ItemMenu(
                    icon: Icons.settings,
                    title: 'Solic.',
                    onPress: () {},
                    subMenu: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey[300], width: 1),
                            ),
                          ),
                          child: SubMenu(
                            title: 'Abastecimento',
                            onPress: () {
                              Navigator.of(context)
                                  .pushNamed('/FormularioAbastecimento');
                            },
                            arrowIcon: Icons.arrow_forward_ios,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey[300], width: 1),
                            ),
                          ),
                          child: SubMenu(
                            title: 'Troca de Óleo',
                            onPress: () {
                              Navigator.of(context)
                                  .pushNamed('/FormularioTrocaDeOleo');
                            },
                            arrowIcon: Icons.arrow_forward_ios,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey[300], width: 1),
                            ),
                          ),
                          child: SubMenu(
                            title: 'Manut. Geral',
                            onPress: () {
                              Navigator.of(context)
                                  .pushNamed('/FormularioManutencao');
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
                );
              }),
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
          ItemMenu(
            icon: Icons.exit_to_app,
            title: 'Sair',
            onPress: () {
              blocMenu.eventoCliqueSair(context, null);
            },
            arrowIcon: Icons.arrow_forward_ios,
            colorMenu: Colors.blueGrey[600],
            colorMenuSelected: Colors.white,
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    );
  }
}

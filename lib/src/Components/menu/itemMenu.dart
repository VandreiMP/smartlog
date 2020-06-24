import 'package:flutter/material.dart';

class ItemMenu extends StatefulWidget {
  const ItemMenu({
    this.title,
    this.icon,
    this.onPress,
    this.arrowIcon,
    this.subMenu,
    this.colorMenu,
    this.fontWeight, 
    this.colorMenuSelected,
  });

  final String title;
  final IconData icon;
  final Function onPress;
  final IconData arrowIcon;
  final Widget subMenu;
  final Color colorMenu;
  final Color colorMenuSelected;
  final FontWeight fontWeight;

  @override
  _ItemMenuState createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  Widget subMenu2;
  IconData arrowIcondinamic;
  bool selected = false;
  Color colorMenu;
  Color colorMenuSelected;
  FontWeight fontWeight;

  Widget build(BuildContext context) {
    if (widget.subMenu == null) {
      subMenu2 = Container();
      colorMenu = widget.colorMenu;
      colorMenuSelected = widget.colorMenuSelected;
      fontWeight = widget.fontWeight;
    } else {
      subMenu2 = widget.subMenu;
      if (!selected) {
        colorMenu = widget.colorMenu;
        colorMenuSelected = widget.colorMenuSelected;
        fontWeight = widget.fontWeight;
      } else {
        colorMenu = Colors.black;
        colorMenuSelected = Colors.blueGrey[200];
        fontWeight = FontWeight.bold;
      }
    }

    if (!selected) {
      arrowIcondinamic = widget.arrowIcon;
    }

    return GestureDetector(
      onTap: () {
        widget.onPress();
        setState(() {
          selected = !selected;
          if (selected) {
            arrowIcondinamic = Icons.keyboard_arrow_down;
          } else {
            arrowIcondinamic = widget.arrowIcon;
            colorMenu = widget.colorMenu;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorMenuSelected,
          border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1),
              top: BorderSide(color: Colors.grey[300], width: 1)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 15),
                    child: Icon(
                      widget.icon,
                      // color: widget.subMenu != null && selected ? Colors.deepPurple : Colors.blueGrey,
                      color: colorMenu,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 15),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: fontWeight,
                        color: colorMenu,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(
                      arrowIcondinamic,
                      color: colorMenu,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.blueGrey[50],
              height: selected ? null : 0,
              child: subMenu2,
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }
}

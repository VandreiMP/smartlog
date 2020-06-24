import 'package:flutter/material.dart';

class SubMenu extends StatelessWidget {
  const SubMenu({this.title, this.onPress, this.arrowIcon, this.colorsubMenu});

  final String title;
  final Function onPress;
  final IconData arrowIcon;
  final Color colorsubMenu;

  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 15),
                child: Icon(
                  //icone de circulo
                  Icons.fiber_manual_record,
                  //icone de seta
                  // Icons.subdirectory_arrow_right,
                  color: Colors.black,
                  size: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 15),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

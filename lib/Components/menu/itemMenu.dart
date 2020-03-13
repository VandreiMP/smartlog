import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({this.title, this.icon, this.onPress, this.arrowIcon});

  final String title;
  final IconData icon;
  final Function onPress;
  final IconData arrowIcon;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.grey[300],
                width: 1
              ),
              top: BorderSide(
                color: Colors.grey[300],
                width: 1
              )),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 15),
                child: Icon(
                  icon,
                  color: Colors.blueGrey,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 15),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 15),
                child: Icon(
                  arrowIcon,
                  color: Colors.blueGrey,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

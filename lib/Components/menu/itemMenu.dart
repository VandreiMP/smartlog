import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    this.title,
    this.icon,
    this.onPress
  });

  final String title;
  final IconData icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 15),
              child: Icon(
                icon,
                size: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 15),
              child: Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

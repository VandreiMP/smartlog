import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
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

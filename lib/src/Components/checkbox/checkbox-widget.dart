import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Modelos/checkBoxModelo.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget(String texto, {Key key, this.item}) : super(key: key);

  final CheckBoxModelo item;

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.item.texto),
      value: widget.item.checked,
      onChanged: (bool value) {
        setState(() {
          widget.item.checked = value;
        });
      },
    );
  }
}

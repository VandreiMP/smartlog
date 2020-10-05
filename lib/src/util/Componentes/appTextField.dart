import 'package:flutter/material.dart';
import 'package:smartlogproject/src/util/Componentes/requiredLabel.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool enabled;
  final bool required;
  final String hint;
  final double width;
  final double heigth;
  final bool password;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final int tamanhoMaximo;
  String valorInicial;

  AppTextField({
    this.label,
    this.enabled = true,
    this.required = false,
    this.hint,
    this.width,
    this.heigth,
    this.password = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.tamanhoMaximo,
    this.valorInicial,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RequiredLabel(label, required),
        _textField(context),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  _textField(context) {
    return Container(
      height: heigth,
      width: width ?? double.maxFinite,
      child: TextFormField(
        maxLengthEnforced: true,
        cursorColor: Colors.black,
        initialValue: valorInicial,
        enabled: enabled,
        controller: controller,
        
        obscureText: password,
        validator: validator,
        keyboardType: TextInputType.datetime,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        onFieldSubmitted: (String text) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(),
      ),
    );
  }
}

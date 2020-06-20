import 'package:flutter/material.dart';
import 'package:smartlogproject/funcoes/requiredLabel.dart';

class AppTextField extends StatelessWidget {
  final String label;
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

  AppTextField({
    this.label,
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
        //maxLength: tamanhoMaximo,
        maxLengthEnforced: true,
        cursorColor: Colors.black,
        //key: Key(label),
        controller: controller,
        obscureText: password,
        validator: validator,
        keyboardType: keyboardType,
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
        decoration: InputDecoration(
            /*border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16)
       ),*/
            /*labelText: label,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),*/
            /*hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14,
          ),*/
            ),
      ),
    );
  }
}

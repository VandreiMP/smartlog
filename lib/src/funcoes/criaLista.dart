import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';

String criaLista() {}

class DropDown extends StatefulWidget {
  final List<String> valores;
  final Function funcaoLista;

  const DropDown({
    this.valores,
    this.funcaoLista,
  });
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String valorSelecionado;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            items: widget.valores.map((
              String dropDownStringItem,
            ) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (
              String novoValorSelecionado,
            ) async {
              widget.funcaoLista;
              setState(() {
                // EmbalagemBloc blocEmbalagem =
                //     BlocProvider.of<EmbalagemBloc>(context);
                // blocEmbalagem.setTipoUnidade(novoValorSelecionado);
                this.valorSelecionado = novoValorSelecionado;
              });
            },
            value: valorSelecionado,
          ),
        ],
      ),
    );
  }
}

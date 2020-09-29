import 'package:intl/intl.dart';

double calculaCubagemEmbalagem(
  double largura,
  double comprimento,
  double altura,
) {
  double retorno;
  NumberFormat formatter = NumberFormat("00000000000.00");

  retorno = (largura * comprimento * altura);

  return double.parse(formatter.format(retorno));
}

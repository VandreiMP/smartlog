import 'package:intl/intl.dart';

double calculaCubagem(
  double largura,
  double comprimento,
  double altura,
) {
  double retorno = 0;
  NumberFormat formatter = NumberFormat("00000000000.00");

  if ((largura != null && largura >0)
      &&(comprimento != null && comprimento > 0)
      &&(altura != null && altura > 0)){
    retorno = (largura * comprimento * altura);
  }
  return double.parse(formatter.format(retorno));
}

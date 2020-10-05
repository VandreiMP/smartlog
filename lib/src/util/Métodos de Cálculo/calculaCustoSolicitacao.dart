import 'package:intl/intl.dart';

double calculaValorTotalSolicitacao(double precoLitro, double quantidade) {
  double retorno;
  NumberFormat formatter = NumberFormat("00000000000.00");

  if (precoLitro != null && quantidade != null) {
    retorno = (precoLitro * quantidade);
  } else {
    retorno = 0;
  }
  return double.parse(formatter.format(retorno));
}

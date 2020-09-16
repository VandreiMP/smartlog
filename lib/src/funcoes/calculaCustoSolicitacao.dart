import 'package:intl/intl.dart';

double calculaValorTotalSolicitacao(double precoLitro, double quantidade) {
  double retorno;
  NumberFormat formatter = NumberFormat("00000000000.00");

  retorno = (precoLitro * quantidade);

  return double.parse(formatter.format(retorno));
}

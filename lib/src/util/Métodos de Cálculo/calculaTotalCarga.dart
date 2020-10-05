double calculaValorTotalCarga(
    double precoLiquido, double unitario, double totalDesp) {
  if ((precoLiquido != null && unitario != null) && totalDesp == null) {
    return (precoLiquido * unitario);
  } else if (precoLiquido == null || unitario == null) {
    return 0.00;
  } else if ((precoLiquido != null && unitario != null && totalDesp != null)) {
    return ((precoLiquido * unitario) + totalDesp);
  } else if ((precoLiquido == null && unitario == null && totalDesp == null)) {
    return 0.00;
  }
}

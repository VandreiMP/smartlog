dynamic retornaPrioridade(String origem, dynamic prioridade) {
  dynamic retorno;

  if (origem == 'INT') {
    print('metodo');
    print(prioridade);
    if (prioridade == 1) {
      retorno = 'Alta';
    } else if (prioridade == 2) {
      retorno = 'Média';
    } else if (prioridade == 3) {
      retorno = 'Baixa';
    }
  } else if (origem == 'STRING') {
    if (prioridade.toString() == 'Alta') {
      retorno = 1;
    } else if (prioridade.toString() == 'Média') {
      retorno = 2;
    } else if (prioridade.toString() == 'Baixa') {
      retorno = 3;
    }
  }
  return retorno;
}

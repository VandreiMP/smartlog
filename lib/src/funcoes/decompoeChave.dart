String decompoeChave(String origem, String chave) {
  if (origem == 'CHAVE_CONSULTA') {
    return chave.substring(0, chave.indexOf('&'));
  } else if (origem == 'IDENTIFICACAO') {
    return chave.substring(chave.lastIndexOf('&') + 1);
  }
}

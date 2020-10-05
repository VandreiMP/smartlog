import 'package:firebase_auth/firebase_auth.dart';

Future<bool> validaAcessoUsuario() async {
  FirebaseAuth instanciaFirebaseAuth = FirebaseAuth.instance;
  bool acessoSistema = false;
  await instanciaFirebaseAuth.currentUser().then(
      (usuario) => acessoSistema = usuario.isEmailVerified
      // usuario.hashCode != null ? acessoSistema = true : acessoSistema = false
      );

  return acessoSistema;
}

import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoService {
  final FirebaseAuth _auth;

  AutenticacaoService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Future<User?> cadastrarUsuario(String email, String senha) async {
    try {
      UserCredential credenciais = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return credenciais.user;
    } catch (erro) {
      return null;
    }
  }

  Future<User?> fazerLogin(String email, String senha) async {
    try {
      UserCredential credenciais = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return credenciais.user;
    } catch (erro) {
      return null;
    }
  }

  Future<void> fazerLogout() async {
    await _auth.signOut();
  }
}

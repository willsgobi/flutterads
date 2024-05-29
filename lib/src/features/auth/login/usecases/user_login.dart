import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ads/src/features/auth/login/models/logged_user.dart';

class UserLogin {
  Future<LoggedUser> doLogin(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        return LoggedUser(user: credential.user, success: true);
      }

      return LoggedUser(
          success: false, errorMessage: "Não foi possível logar com o usuário");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return LoggedUser(
            success: false, errorMessage: "Usuário não encontrado");
      } else if (e.code == 'wrong-password') {
        return LoggedUser(success: false, errorMessage: "Senha inválida");
      }

      return LoggedUser(success: false, errorMessage: e.toString());
    }
  }
}

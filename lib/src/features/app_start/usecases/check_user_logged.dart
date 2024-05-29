import 'package:firebase_auth/firebase_auth.dart';

class CheckUserLogged {
  Future<bool> userIsLogged() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}

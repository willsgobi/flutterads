import 'package:firebase_auth/firebase_auth.dart';

class DoSignOut {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

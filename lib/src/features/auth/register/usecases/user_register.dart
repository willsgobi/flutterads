import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ads/src/features/auth/register/models/user_registered.dart';

class UserRegister {
  Future<UserCreated> doRegisterAccount(
      String name, String email, String password) async {
    try {
      final userRegistered = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userRegistered.user != null) {
        await userRegistered.user!.updateDisplayName(name);
        return UserCreated(success: true, user: userRegistered.user);
      }

      return UserCreated(success: false);
    } catch (e) {
      print(e.toString());
      return UserCreated(success: false, errorMessage: e.toString());
    }
  }
}

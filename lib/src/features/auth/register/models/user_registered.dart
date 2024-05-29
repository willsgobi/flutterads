import 'package:firebase_auth/firebase_auth.dart';

class UserCreated {
  final bool success;
  final User? user;
  final String? errorMessage;

  UserCreated({required this.success, this.user, this.errorMessage});
}

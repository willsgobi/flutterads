import 'package:firebase_auth/firebase_auth.dart';

class LoggedUser {
  final bool success;
  final User? user;
  final String? errorMessage;

  LoggedUser({this.user, required this.success, this.errorMessage});
}

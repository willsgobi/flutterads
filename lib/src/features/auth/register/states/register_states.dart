import 'package:flutter_ads/src/features/auth/register/models/user_registered.dart';

sealed class RegisterState {}

class LoadingRegisterState extends RegisterState {}

class InitialRegisterState extends RegisterState {}

class ErrorRegisterState extends RegisterState {
  final String errorMessage;

  ErrorRegisterState({required this.errorMessage});
}

class SuccessRegisterState extends RegisterState {
  final UserCreated userCreated;

  SuccessRegisterState({required this.userCreated});
}

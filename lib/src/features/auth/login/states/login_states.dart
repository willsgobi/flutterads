sealed class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoggedState extends LoginState {}

class ErrorLogginState extends LoginState {
  final String errorMessage;

  ErrorLogginState({required this.errorMessage});
}

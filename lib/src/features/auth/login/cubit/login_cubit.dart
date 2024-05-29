import 'package:bloc/bloc.dart';
import 'package:flutter_ads/src/features/auth/login/states/login_states.dart';
import 'package:flutter_ads/src/features/auth/login/usecases/user_login.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserLogin _userLogin;
  LoginCubit(this._userLogin) : super(InitialLoginState());

  Future login(String email, String password) async {
    emit(LoadingLoginState());
    if (email.isEmpty) {
      emit(ErrorLogginState(errorMessage: "O e-mail precisa ser informado."));
      return;
    }
    if (password.isEmpty) {
      emit(ErrorLogginState(errorMessage: "A senha precisa ser informada."));
      return;
    }
    final logged = await _userLogin.doLogin(email, password);

    if (logged.success) {
      emit(LoggedState());
    } else {
      emit(ErrorLogginState(errorMessage: logged.errorMessage!));
    }
  }
}

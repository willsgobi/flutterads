import 'package:bloc/bloc.dart';
import 'package:flutter_ads/src/features/auth/register/states/register_states.dart';
import 'package:flutter_ads/src/features/auth/register/usecases/user_register.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UserRegister userRegister;

  RegisterCubit(this.userRegister) : super(InitialRegisterState());

  Future registerUser(String name, String email, String password) async {
    emit(LoadingRegisterState());
    if (name.isEmpty) {
      emit(ErrorRegisterState(errorMessage: 'O nome precisa ser informado'));
      return;
    }

    if (email.isEmpty) {
      emit(ErrorRegisterState(errorMessage: 'O e-mail precisa ser informado'));
      return;
    }

    if (password.isEmpty) {
      emit(ErrorRegisterState(errorMessage: 'A senha precisa ser informada'));
      return;
    }

    final userRegistered =
        await userRegister.doRegisterAccount(name, email, password);

    if (userRegistered.success) {
      emit(SuccessRegisterState(userCreated: userRegistered));
    } else {
      emit(ErrorRegisterState(errorMessage: userRegistered.errorMessage!));
    }
  }
}

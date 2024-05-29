import 'package:bloc/bloc.dart';
import 'package:flutter_ads/src/features/ads/states/ads_states.dart';
import 'package:flutter_ads/src/features/ads/usecases/get_user_data.dart';

class AdsCubit extends Cubit<AdsState> {
  final GetUserData _userData;
  AdsCubit(this._userData) : super(InitialAdsState());

  Future getUserData() async {
    emit(LoadingUserData());
    var userData = await _userData.getUserData();

    if (userData != null) {
      emit(LoadedUserDataAdsState(userData: userData));
    } else {
      emit(ErrorLoadUserData());
    }
  }
}

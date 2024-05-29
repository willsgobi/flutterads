import 'package:flutter_ads/src/features/ads/model/user_data.dart';

sealed class AdsState {}

class InitialAdsState extends AdsState {}

class LoadedUserDataAdsState extends AdsState {
  final UserData? userData;

  LoadedUserDataAdsState({required this.userData});
}

class LoadingUserData extends AdsState {}

class ErrorLoadUserData extends AdsState {}

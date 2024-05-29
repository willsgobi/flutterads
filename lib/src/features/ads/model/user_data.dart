import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ads/src/features/ads/model/interests.dart';

class UserData {
  final User? user;
  final List<Interests>? interests;

  UserData({required this.user, this.interests});
}

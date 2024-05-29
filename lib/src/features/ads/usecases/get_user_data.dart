import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ads/src/features/ads/model/interests.dart';
import 'package:flutter_ads/src/features/ads/model/user_data.dart';
import 'dart:core';

class GetUserData {
  Future<UserData?> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Usuário está autenticado, agora recupere os interesses do Firestore
      QuerySnapshot userInterestsQuery = await FirebaseFirestore.instance
          .collection('interest')
          .where('userId', isEqualTo: user.uid)
          .get();

      if (userInterestsQuery.docs.isNotEmpty) {
        List<Interests> interestsList = [];

        for (var doc in userInterestsQuery.docs) {
          Interests interest = Interests.fromFirestore(doc);
          interestsList.add(interest);
        }

        // Verifique se o documento contém o campo 'interests'
        return UserData(user: user, interests: interestsList);
      } else {
        // Não há documentos com o ID do usuário
        return UserData(user: user);
      }
    } else {
      // Usuário não está autenticado
      return null;
    }
  }
}

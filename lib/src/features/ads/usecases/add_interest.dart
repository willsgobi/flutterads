import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddInterest {
  Future add(String myInterest) async {
    CollectionReference interest =
        FirebaseFirestore.instance.collection('interest');
    interest.add({
      'interest': myInterest,
      'userId': FirebaseAuth.instance.currentUser!.uid
    });
  }
}

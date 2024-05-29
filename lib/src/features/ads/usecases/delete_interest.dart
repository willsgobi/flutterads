import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteInterest {
  Future<bool> deleteInterest(String interestId) async {
    try {
      await FirebaseFirestore.instance
          .collection("interest")
          .doc(interestId)
          .delete();
      return true;
    } catch (e) {
      print("Error deleting interest: $e");
      return false;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Interests {
  final String id;
  final String interest;

  Interests({required this.id, required this.interest});

  factory Interests.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Interests(
      id: doc.id,
      interest: data['interest'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'interest': interest,
    };
  }
}

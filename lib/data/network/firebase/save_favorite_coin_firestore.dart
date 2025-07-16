import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveFavoriteCoin(String userId, Map<String, dynamic> coin) async {
  final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
  await userDoc.set({
    'currencies': FieldValue.arrayUnion([coin]),
  }, SetOptions(merge: true));
}

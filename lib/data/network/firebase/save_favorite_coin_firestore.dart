import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveFavoriteCoinFirestore(String userId, Map<String, dynamic> coin) async {
  final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
  await userDoc.set({
    'currencies': FieldValue.arrayUnion([coin]),
  }, SetOptions(merge: true));
}

Future<bool> verifyCoinExists(String userId, String coinId) async {
  final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
  final docSnapshot = await userDoc.get();

  if (docSnapshot.exists) {
    final data = docSnapshot.data();
    if (data != null && data.containsKey('currencies')) {
      final currencies = data['currencies'] as List<dynamic>;
      return currencies.any((coin) => coin['name'] == coinId);
    }
  }
  return false;
}
Future<List<String>> getUserFavorites(String userId) async {
  final doc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
  final data = doc.data();
  final currencies = data?['currencies'] as List<dynamic>? ?? [];

  // Mapeia cada moeda para o seu nome (String)
  final favoriteNames = currencies
      .map((coin) => coin['name'] as String)
      .toList();

  return favoriteNames;
}

Future<void> deleteCoinFirestore(String userId, String coinId) async {
  final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);

  try {
    final doc = await userDoc.get();

    if (doc.exists) {
      final data = doc.data();
      final currencies = data?['currencies'];

      if (currencies != null && currencies is List) {
        for (var currency in currencies) {
          if (currency['symbol'] == coinId) {
            await userDoc.update({
              'currencies': FieldValue.arrayRemove([currency]),
            });
            print('Moeda removida: ${currency['symbol']}');
            break; // sai do loop após remover
          }
        }
      } else {
        print('Campo currencies não existe ou não é lista');
      }
    } else {
      print('Documento do usuário não encontrado');
    }
  } catch (e) {
    print('Erro ao buscar documento: $e');
  }

}

Future<void> deleteUserDocument(String userId) async {
  final userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
  try {
    await userDoc.delete();
    print('Documento do usuário $userId deletado com sucesso.');
  } catch (e) {
    print('Erro ao deletar documento do usuário: $e');
  }
}

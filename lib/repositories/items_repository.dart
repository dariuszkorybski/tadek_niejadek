import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tadek_niejadek/models/item_model.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .orderBy('name')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ItemModel(
            id: doc.id,
            name: doc['name'],
            gender: doc['gender'],
            height: doc['height'],
            weight: doc['weight'],
            image: doc['image'],
            dateTime: (doc['dateTime'] as Timestamp).toDate());
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .delete();
  }

  Future<ItemModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .get();
    return ItemModel(
      id: doc.id,
      name: doc['name'],
      gender: doc['gender'],
      height: doc['height'],
      weight: doc['weight'],
      image: doc['image'],
      dateTime: (doc['dateTime'] as Timestamp).toDate(),
    );
  }

  Future<void> add(
    String name,
    DateTime dateTime,
    String height,
    String weight,
    String gender,
    String image,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .add(
      {
        'name': name,
        'dataTime': dateTime,
        'gender': gender,
        'height': height,
        'weight': weight,
        'image': image,
      },
    );
  }
}

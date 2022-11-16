import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tadek_niejadek/models/child_model.dart';

class ChildRepository {
  Stream<List<ChildModel>> getChildStream() {
    return FirebaseFirestore.instance
        .collection('child')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return ChildModel(
            id: doc.id,
            name: doc['name'],
            gender: doc['gender'],
            height: doc['height'],
            weight: doc['weight'],
            image: doc['image'],
            dateTime: doc['dateTime']);
      }).toList();
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance.collection('child').doc(id).delete();
  }

  Future<void> add(
    String name,
    DateTime dateTime,
    String height,
    String weight,
    String gender,
    String image,
  ) async {
    
      await FirebaseFirestore.instance.collection('child').add({
        'name': name,
        'dataTime': dateTime,
        'gender': gender,
        'height': height,
        'weight': weight,
        'image': image,
      },);
    
}
  }
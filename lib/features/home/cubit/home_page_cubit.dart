import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:tadek_niejadek/models/child_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(const HomePageState());

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription =
        FirebaseFirestore.instance.collection('child').snapshots().listen(
      (child) {
              final childModels = child.docs.map((doc) {
                return ChildModel(
                    id: doc.id,
                    name: doc['name'],
                    gender: doc['gender'],
                    height: doc['height'],
                    weight: doc['weight'],
                    imageUrl: doc['imageUrl'],
                    dateTime: doc['dateTime']);
              }).toList();
              emit(HomePageState(child: childModels));
            },
          );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('child')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        const HomePageState(removingErrorOccured: true),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tadek_niejadek/models/child_model.dart';
import 'package:tadek_niejadek/repositories/child_repository.dart';

part 'child_state.dart';

class ChildCubit extends Cubit<ChildState> {
  ChildCubit(this._childRepository) : super(const ChildState());

  final ChildRepository _childRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription = _childRepository.getChildStream().listen(
      (child) {
        emit(ChildState(child: child));
      },
    );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _childRepository.delete(id: documentID);
    } catch (error) {
      emit(
        const ChildState(removingErrorOccured: true),
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

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/repositories/items_repository.dart';


part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemsRepository)
      : super(
          const AddState(),
        );

  final ItemsRepository _itemsRepository;

  Future<void> add(
    String name,
    String gender,
    String image,
    DateTime dateTime,
  ) async {
    try {
      await _itemsRepository.add(
        name,
        gender,
        image,
        dateTime,
      );
      emit(const AddState(saved: true));
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}

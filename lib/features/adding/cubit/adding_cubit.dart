import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/repositories/items_repository.dart';


part 'adding_state.dart';

class AddingCubit extends Cubit<AddingState> {
  AddingCubit(this._itemsRepository)
      : super(
          const AddingState(),
        );

  final ItemsRepository _itemsRepository;

  Future<void> add(
    String name,
    DateTime dateTime,
    String height,
    String weight,
    String gender,
    String image,
  ) async {
    try {
      await _itemsRepository.add(
        name,
        dateTime,
        gender,
        height,
        weight,
        image,
      );
      emit(const AddingState(saved: true));
    } catch (error) {
      emit(AddingState(errorMessage: error.toString()));
    }
  }
}

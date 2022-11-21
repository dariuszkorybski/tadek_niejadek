import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/repositories/child_repository.dart';

part 'adding_state.dart';

class AddingCubit extends Cubit<AddingState> {
  AddingCubit(this._childRepository)
      : super(
          const AddingState(),
        );

  final ChildRepository _childRepository;

  Future<void> add(
    String name,
    DateTime dateTime,
    String height,
    String weight,
    String gender,
    String image,
  ) async {
    try {
      await _childRepository.add(
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

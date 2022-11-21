import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadek_niejadek/models/child_model.dart';
import 'package:tadek_niejadek/repositories/child_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._childRepository) : super(DetailsState(childModel: null));

  final ChildRepository _childRepository;

  Future<void>getChildWithID (String id) async {
  final childModel = await _childRepository.get(id: id);
  emit(DetailsState(childModel: childModel));
  }
}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

part 'adding_state.dart';

class AddingCubit extends Cubit<AddingState> {
  AddingCubit() : super( const AddingState(),);

  Future<void> add(
   String name,
   DateTime dateTime,
   String height,
   String weight,
   String gender,
   String imageUrl,
   ) async {
    try {
      await FirebaseFirestore.instance.collection('child').add(
      {
        'name' : name,
        'date_of_birth' : dateTime,
        'gender' : gender,
        'height' : height,
        'weight' : weight,
        'photo' : imageUrl

      });
      emit( const AddingState(saved: true));
    } catch (error) {
      emit (AddingState( errorMessage: error.toString()));
    }
   }
}

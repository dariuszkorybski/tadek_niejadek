part of 'adding_cubit.dart';

class AddingState {
  const AddingState({
    this.saved = false,
    this.errorMessage = '',
    
  });
  final bool saved;
  final String errorMessage;
  

  String? dateFormatted() {
    return DateFormat.MMMEd().format(dateTime);
  }
}

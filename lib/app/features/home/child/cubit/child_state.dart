part of 'child_cubit.dart';

class ChildState {
  const ChildState({
    this.child = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,

  });

  final List<ChildModel> child;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

 
}

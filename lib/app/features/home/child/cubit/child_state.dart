part of 'child_cubit.dart';

class ChildState {
  final List<ChildModel> child;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;

  const ChildState({
    this.child = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
}

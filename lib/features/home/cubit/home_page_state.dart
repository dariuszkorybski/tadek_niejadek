part of 'home_page_cubit.dart';

@immutable
class HomePageState {
   const HomePageState({
    this.child = const [],
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
    
  });
  final List<ChildModel> child;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
  
}



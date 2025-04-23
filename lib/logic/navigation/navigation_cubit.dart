// navigation_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationState {
  final int selectedIndex;

  NavigationState({required this.selectedIndex});
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(selectedIndex: 0));

  void updateIndex(int index) {
    emit(NavigationState(selectedIndex: index));
  }
}

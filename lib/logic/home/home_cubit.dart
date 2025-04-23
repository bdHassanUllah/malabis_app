
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/data/repository/home_repository.dart';
import 'package:malabis_app/logic/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());

  Future<void> loadProducts() async {
    emit(HomeLoading());
    try {
      final products = await repository.getProducts();
      emit(HomeLoaded(products));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

}
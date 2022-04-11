import 'package:cubitapp/bloc/home/cats_repository.dart';
import 'package:cubitapp/bloc/home/cats_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsCubit extends Cubit<CatsState> {
  final CatsRepository catsRepository;

  CatsCubit(this.catsRepository) : super(const CatsInitial()) {
    getCats();
  }

  Future<void> getCats() async {
    try {
      emit(const CatsLoading());
      final response = await catsRepository.getCatsFromApi();
      emit(CatsCompleted(response));
    } catch (e) {
      emit(CatsError(e.toString()));
    }
  }
}

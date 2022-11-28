import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_popular_movies.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  final GetPopularMovies _popularMovies;

  PopularCubit(this._popularMovies) : super(PopularEmpty());

  Future<void> getData() async {
    emit(PopularLoading());
    final result = await _popularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularError(failure.message));
      },
      (data) {
        emit(PopularHasData(data));
      },
    );
  }
}

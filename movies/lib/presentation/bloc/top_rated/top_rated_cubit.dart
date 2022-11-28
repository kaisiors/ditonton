import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_top_rated_movies.dart';

part 'top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final GetTopRatedMovies _topRatedMovies;

  TopRatedCubit(this._topRatedMovies) : super(TopRatedEmpty());

  Future<void> getData() async {
    emit(TopRatedLoading());
    final result = await _topRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedError(failure.message));
      },
      (data) {
        emit(TopRatedHasData(data));
      },
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part 'search_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieCubit(this.searchMovies) : super(SearchMovieEmpty());

  Future<void> resultData(String query) async {
    emit(SearchMovieLoading());
    final result = await searchMovies.execute(query);

    result.fold(
      (failure) {
        emit(SearchMovieError(failure.message));
      },
      (data) {
        emit(SearchMovieHasData(data));
      },
    );
  }
}

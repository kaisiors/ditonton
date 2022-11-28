import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';

part 'recommendation_state.dart';

class RecommendationMovieCubit extends Cubit<RecommendationMovieState> {
  final GetMovieRecommendations recommendationMovies;

  RecommendationMovieCubit(this.recommendationMovies)
      : super(RecommendationEmpty());

  Future<void> getData(int id) async {
    emit(RecommendationLoading());

    final result = await recommendationMovies.execute(id);

    result.fold(
      (failure) {
        emit(RecommendationError(failure.message));
      },
      (data) {
        emit(RecommendationHasData(data));
      },
    );
  }
}

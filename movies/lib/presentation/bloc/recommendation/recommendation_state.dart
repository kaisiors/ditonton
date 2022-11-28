part of 'recommendation_cubit.dart';

abstract class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationEmpty extends RecommendationMovieState {}

class RecommendationLoading extends RecommendationMovieState {}

class RecommendationError extends RecommendationMovieState {
  final String message;

  const RecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationHasData extends RecommendationMovieState {
  final List<Movie> result;

  const RecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}

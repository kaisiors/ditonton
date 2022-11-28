part of 'recommendation_cubit.dart';

abstract class RecommendationTvSeriesState extends Equatable {
  const RecommendationTvSeriesState();

  @override
  List<Object> get props => [];
}

class RecommendationEmpty extends RecommendationTvSeriesState {}

class RecommendationLoading extends RecommendationTvSeriesState {}

class RecommendationError extends RecommendationTvSeriesState {
  final String message;

  const RecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationHasData extends RecommendationTvSeriesState {
  final List<TvSeries> result;

  const RecommendationHasData(this.result);

  @override
  List<Object> get props => [result];
}

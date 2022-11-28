part of 'episode_cubit.dart';

abstract class EpisodeTvSeriesState extends Equatable {
  const EpisodeTvSeriesState();

  @override
  List<Object> get props => [];
}

class EpisodeEmpty extends EpisodeTvSeriesState {}

class EpisodeLoading extends EpisodeTvSeriesState {}

class EpisodeError extends EpisodeTvSeriesState {
  final String message;

  const EpisodeError(this.message);

  @override
  List<Object> get props => [message];
}

class EpisodeHasData extends EpisodeTvSeriesState {
  final List<Episode> result;

  const EpisodeHasData(this.result);

  @override
  List<Object> get props => [result];
}

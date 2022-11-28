part of 'detail_cubit.dart';

abstract class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends DetailTvSeriesState {}

class DetailLoading extends DetailTvSeriesState {}

class DetailError extends DetailTvSeriesState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends DetailTvSeriesState {
  final TvSeriesDetail result;

  const DetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

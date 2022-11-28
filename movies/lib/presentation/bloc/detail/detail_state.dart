part of 'detail_cubit.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();

  @override
  List<Object> get props => [];
}

class DetailEmpty extends DetailMovieState {}

class DetailLoading extends DetailMovieState {}

class DetailError extends DetailMovieState {
  final String message;

  const DetailError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailHasData extends DetailMovieState {
  final MovieDetail result;

  const DetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

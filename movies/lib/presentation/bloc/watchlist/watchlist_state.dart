part of 'watchlist_cubit.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistMovieState {}

class WatchlistLoading extends WatchlistMovieState {}

class WatchlistError extends WatchlistMovieState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistMovieState {
  final List<Movie> result;

  const WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class IsAddedToWatchlist extends WatchlistMovieState {
  final bool isAddedToWatchlist;

  const IsAddedToWatchlist({this.isAddedToWatchlist = false});

  @override
  List<Object> get props => [isAddedToWatchlist];
}

part of 'watchlist_cubit.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistTvSeriesState {}

class WatchlistLoading extends WatchlistTvSeriesState {}

class WatchlistError extends WatchlistTvSeriesState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistTvSeriesState {
  final List<TvSeries> result;

  const WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class IsAddedToWatchlist extends WatchlistTvSeriesState {
  final bool isAddedToWatchlist;

  const IsAddedToWatchlist({this.isAddedToWatchlist = false});

  @override
  List<Object> get props => [isAddedToWatchlist];
}

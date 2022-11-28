import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_watchlist_status.dart';
import '../../../../domain/usecases/remove_watchlist.dart';
import '../../../../domain/usecases/save_watchlist.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_watchlist_movies.dart';

part 'watchlist_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  String message = '';

  WatchlistMovieCubit(this.getWatchListStatus, this.removeWatchlist,
      this.saveWatchlist, this.getWatchlistMovies)
      : super(WatchlistEmpty());

  Future<void> getDataWatchlist() async {
    emit(WatchlistLoading());
    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistError(failure.message));
      },
      (data) {
        emit(WatchlistHasData(data));
      },
    );
  }

  Future<void> getStatus(int id) async {
    final result = await getWatchListStatus.execute(id);

    result
        ? message = watchlistAddSuccessMessage
        : message = watchlistRemoveSuccessMessage;

    emit(IsAddedToWatchlist(isAddedToWatchlist: result));
  }

  Future<void> addToWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(const IsAddedToWatchlist(isAddedToWatchlist: false));
        message = failure.message;
      },
      (data) async {
        emit(const IsAddedToWatchlist(isAddedToWatchlist: true));
        message = data;
      },
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(const IsAddedToWatchlist(isAddedToWatchlist: true));
        message = failure.message;
      },
      (data) async {
        emit(const IsAddedToWatchlist(isAddedToWatchlist: false));
        message = data;
      },
    );
  }
}

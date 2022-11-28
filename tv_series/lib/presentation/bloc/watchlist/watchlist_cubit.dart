import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/tv_series.dart';
import '../../../domain/entities/tv_series_detail.dart';
import '../../../domain/usecases/get_watchlist_tv_series.dart';
import '../../../domain/usecases/get_watchlist_tv_series_status.dart';
import '../../../domain/usecases/remove_watchlist_tv_series.dart';
import '../../../domain/usecases/save_watchlist_tv_series.dart';

part 'watchlist_state.dart';

class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final GetWatchListTvSeriesStatus getWatchListStatus;
  final SaveWatchlistTvSeries saveWatchlist;
  final RemoveWatchlistTvSeries removeWatchlist;
  String message = '';

  WatchlistTvSeriesCubit(this.getWatchListStatus, this.removeWatchlist,
      this.saveWatchlist, this.getWatchlistTvSeries)
      : super(WatchlistEmpty());

  Future<void> getDataWatchlist() async {
    emit(WatchlistLoading());
    final result = await getWatchlistTvSeries.execute();

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

  Future<void> addToWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveWatchlist.execute(tvSeries);

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

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeWatchlist.execute(tvSeries);

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

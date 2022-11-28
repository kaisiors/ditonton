import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_now_playing_tv_series.dart';

part 'now_playing_state.dart';

class NowPlayingTvSeriesCubit extends Cubit<NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries _nowPlayingTvSeries;

  NowPlayingTvSeriesCubit(this._nowPlayingTvSeries)
      : super(NowPlayingTvSeriesEmpty());

  Future<void> getData() async {
    emit(NowPlayingTvSeriesLoading());
    final result = await _nowPlayingTvSeries.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTvSeriesError(failure.message));
      },
      (data) {
        emit(NowPlayingTvSeriesHasData(data));
      },
    );
  }
}

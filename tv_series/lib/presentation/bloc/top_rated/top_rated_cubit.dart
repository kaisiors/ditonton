import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../../domain/usecases/get_top_rated_tv_series.dart';

part 'top_rated_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTopRatedTvSeries _topRatedTvSeries;

  TopRatedTvSeriesCubit(this._topRatedTvSeries)
      : super(TopRatedTvSeriesEmpty());

  Future<void> getData() async {
    emit(TopRatedTvSeriesLoading());
    final result = await _topRatedTvSeries.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvSeriesError(failure.message));
      },
      (data) {
        emit(TopRatedTvSeriesHasData(data));
      },
    );
  }
}

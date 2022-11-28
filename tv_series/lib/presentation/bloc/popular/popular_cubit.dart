import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../../domain/usecases/get_popular_tv_series.dart';

part 'popular_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTvSeries _popularTvSeries;

  PopularTvSeriesCubit(this._popularTvSeries) : super(PopularTvSeriesEmpty());

  Future<void> getData() async {
    emit(PopularTvSeriesLoading());
    final result = await _popularTvSeries.execute();

    result.fold(
      (failure) {
        emit(PopularTvSeriesError(failure.message));
      },
      (data) {
        emit(PopularTvSeriesHasData(data));
      },
    );
  }
}

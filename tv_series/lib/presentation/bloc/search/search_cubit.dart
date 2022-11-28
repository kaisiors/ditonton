import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series.dart';

part 'search_state.dart';

class SearchTvSeriesCubit extends Cubit<SearchTvSeriesState> {
  final SearchTvSeries searchTvSeries;

  SearchTvSeriesCubit(this.searchTvSeries) : super(SearchTvSeriesEmpty());

  Future<void> resultData(String query) async {
    emit(SearchTvSeriesLoading());
    final result = await searchTvSeries.execute(query);

    result.fold(
      (failure) {
        emit(SearchTvSeriesError(failure.message));
      },
      (data) {
        emit(SearchTvSeriesHasData(data));
      },
    );
  }
}

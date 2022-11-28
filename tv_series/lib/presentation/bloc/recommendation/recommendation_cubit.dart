import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations.dart';

part 'recommendation_state.dart';

class RecommendationTvSeriesCubit extends Cubit<RecommendationTvSeriesState> {
  final GetTvSeriesRecommendations recommendationTvSeries;

  RecommendationTvSeriesCubit(this.recommendationTvSeries)
      : super(RecommendationEmpty());

  Future<void> getData(int id) async {
    emit(RecommendationLoading());

    final result = await recommendationTvSeries.execute(id);

    result.fold(
      (failure) {
        emit(RecommendationError(failure.message));
      },
      (data) {
        emit(RecommendationHasData(data));
      },
    );
  }
}

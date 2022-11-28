import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

import '../../../domain/usecases/get_tv_series_detail.dart';

part 'detail_state.dart';

class DetailTvSeriesCubit extends Cubit<DetailTvSeriesState> {
  final GetTvSeriesDetail detailTvSeries;

  DetailTvSeriesCubit(this.detailTvSeries) : super(DetailEmpty());

  Future<void> getDetail(int id) async {
    emit(DetailLoading());

    final result = await detailTvSeries.execute(id);

    result.fold(
      (failure) {
        emit(DetailError(failure.message));
      },
      (data) {
        emit(DetailHasData(data));
      },
    );
  }
}

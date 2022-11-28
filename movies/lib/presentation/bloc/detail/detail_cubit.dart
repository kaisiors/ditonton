import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/entities/movie_detail.dart';

part 'detail_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  final GetMovieDetail detailMovies;

  DetailMovieCubit(this.detailMovies) : super(DetailEmpty());

  Future<void> getDetail(int id) async {
    emit(DetailLoading());

    final result = await detailMovies.execute(id);

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

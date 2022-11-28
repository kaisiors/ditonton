import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final GetNowPlayingMovies _nowPlayingMovies;

  NowPlayingCubit(this._nowPlayingMovies) : super(NowPlayingEmpty());

  Future<void> getData() async {
    emit(NowPlayingLoading());
    final result = await _nowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingError(failure.message));
      },
      (data) {
        emit(NowPlayingHasData(data));
      },
    );
  }
}

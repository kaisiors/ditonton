import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/episode.dart';
import '../../../domain/usecases/get_episode_tv_series.dart';

part 'episode_state.dart';

class EpisodeTvSeriesCubit extends Cubit<EpisodeTvSeriesState> {
  final GetEpisodeTvSeries episodeTvSeries;

  EpisodeTvSeriesCubit(this.episodeTvSeries) : super(EpisodeEmpty());

  Future<void> getEpisode(int id, int seasonNumber) async {
    emit(EpisodeLoading());

    final result = await episodeTvSeries.execute(id, seasonNumber);

    result.fold(
      (failure) {
        emit(EpisodeError(failure.message));
      },
      (data) {
        emit(EpisodeHasData(data));
      },
    );
  }
}

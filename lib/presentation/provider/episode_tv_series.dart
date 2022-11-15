import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter/foundation.dart';

import '../../common/state_enum.dart';
import '../../domain/usecases/get_episode_tv_series.dart';

class EpisodeTvSeriesNotifier extends ChangeNotifier {
  final GetEpisodeTvSeries getEpisodeTvSeries;

  EpisodeTvSeriesNotifier({required this.getEpisodeTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Episode> _episodes = [];
  List<Episode> get episodes => _episodes;

  String _message = '';
  String get message => _message;

  Future<void> fetchEpisodeTvSeries(int id, int seasonNumber) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getEpisodeTvSeries.execute(id, seasonNumber);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (episodeData) {
        _episodes = episodeData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

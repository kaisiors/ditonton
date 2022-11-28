import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    id: 1,
    overview: 'overview',
    name: 'name',
    voteAverage: 1,
    airDate: 'airDate',
    stillPath: 'stillPath',
  );

  const tEpisode = Episode(
    id: 1,
    overview: 'overview',
    name: 'name',
    voteAverage: 1,
    airDate: 'airDate',
    stillPath: 'stillPath',
  );

  test('should be a subclass of Episode entity', () async {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}

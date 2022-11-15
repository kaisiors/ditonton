import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
    id: 1,
    overview: 'overview',
    name: 'name',
    voteAverage: 1,
    airDate: 'airDate',
    stillPath: 'stillPath',
  );

  final tEpisode = Episode(
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

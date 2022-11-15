import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeasonModel = SeasonModel(
    id: 1,
    name: 'name',
    episodeCount: 1,
    seasonNumber: 1,
  );

  final tSeason = Season(
    id: 1,
    name: 'name',
    episodeCount: 1,
    seasonNumber: 1,
  );

  test('should be a subclass of Season entity', () async {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
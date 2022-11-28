import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  const tSeasonModel = SeasonModel(
    id: 1,
    name: 'name',
    episodeCount: 1,
    seasonNumber: 1,
  );

  const tSeason = Season(
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

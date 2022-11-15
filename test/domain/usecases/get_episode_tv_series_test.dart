import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episode_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetEpisodeTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetEpisodeTvSeries(mockTvSeriesRepository);
  });

  final tEpisode = <Episode>[];
  final tId = 1;
  final tSeasonNumber = 1;

  test('should get list of episode from repository', () async {
    // arrange
    when(mockTvSeriesRepository.getEpisodeTvSeries(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(tEpisode));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, Right(tEpisode));
  });
}

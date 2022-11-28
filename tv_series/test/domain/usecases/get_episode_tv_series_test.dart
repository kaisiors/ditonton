import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetEpisodeTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetEpisodeTvSeries(mockTvSeriesRepository);
  });

  final tEpisode = <Episode>[];
  const tId = 1;
  const tSeasonNumber = 1;

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

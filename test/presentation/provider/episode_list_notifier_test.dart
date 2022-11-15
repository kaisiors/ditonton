import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_episode_tv_series.dart';
import 'package:ditonton/presentation/provider/episode_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'episode_list_notifier_test.mocks.dart';

@GenerateMocks([GetEpisodeTvSeries])
void main() {
  late EpisodeTvSeriesNotifier provider;
  late MockGetEpisodeTvSeries mockGetEpisodeTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetEpisodeTvSeries = MockGetEpisodeTvSeries();
    provider =
        EpisodeTvSeriesNotifier(getEpisodeTvSeries: mockGetEpisodeTvSeries)
          ..addListener(() {
            listenerCallCount += 1;
          });
  });

  final tEpisode = Episode(
      id: 1,
      overview: 'overview',
      name: 'name',
      voteAverage: 1,
      airDate: '2022-01-01',
      stillPath: 'stillPath');
  final tEpisodeList = <Episode>[tEpisode];
  final tId = 1;
  final tSeasonNumber = 1;

  group('episode tv series', () {
    test('initialState should be Empty', () {
      expect(provider.state, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      provider.fetchEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      verify(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      provider.fetchEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change episodes when data is gotten successfully', () async {
      // arrange
      when(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
      // act
      await provider.fetchEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.episodes, tEpisodeList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchEpisodeTvSeries(tId, tSeasonNumber);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

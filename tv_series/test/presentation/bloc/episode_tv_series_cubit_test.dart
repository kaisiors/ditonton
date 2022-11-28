import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'episode_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetEpisodeTvSeries])
void main() {
  late EpisodeTvSeriesCubit episodeTvSeriesCubit;
  late MockGetEpisodeTvSeries mockGetEpisodeTvSeries;

  setUp(() {
    mockGetEpisodeTvSeries = MockGetEpisodeTvSeries();
    episodeTvSeriesCubit = EpisodeTvSeriesCubit(mockGetEpisodeTvSeries);
  });

  test('initial state should be empty', () {
    expect(episodeTvSeriesCubit.state, EpisodeEmpty());
  });

  const tEpisode = Episode(
    airDate: "2022-08-21",
    id: 1971015,
    name: "The Heirs of the Dragon",
    overview:
        "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
    stillPath: "/3V447myclihccqnSiVFVdlnNjZs.jpg",
    voteAverage: 8.013,
  );
  final tEpisodeList = <Episode>[tEpisode];
  const tId = 1;
  const tSeasonNumber = 1;

  blocTest<EpisodeTvSeriesCubit, EpisodeTvSeriesState>(
    'Should emit [Loading, HasData] when data of episode is gotten successfully.',
    build: () {
      when(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(tEpisodeList));
      return episodeTvSeriesCubit;
    },
    act: (cubit) => cubit.getEpisode(tId, tSeasonNumber),
    expect: () => [
      EpisodeLoading(),
      EpisodeHasData(tEpisodeList),
    ],
    verify: (cubit) {
      verify(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get episode is unsuccessful',
    build: () {
      when(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return episodeTvSeriesCubit;
    },
    act: (cubit) => cubit.getEpisode(tId, tSeasonNumber),
    expect: () => [
      EpisodeLoading(),
      const EpisodeError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetEpisodeTvSeries.execute(tId, tSeasonNumber));
    },
  );
}

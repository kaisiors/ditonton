import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'recommendation_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late RecommendationTvSeriesCubit recommendationTvSeriesCubit;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    recommendationTvSeriesCubit =
        RecommendationTvSeriesCubit(mockGetTvSeriesRecommendations);
  });

  test('initial state should be empty', () {
    expect(recommendationTvSeriesCubit.state, RecommendationEmpty());
  });

  final tTvSeries = TvSeries(
    backdropPath: '/etj8E2o0Bud0HkONVQPjyCkIvpv.jpg',
    genreIds: const [10765, 18, 10759],
    id: 94997,
    originalName: 'House of the Dragon',
    overview:
        'The Targaryen dynasty is at the absolute apex of its power, with more than 15 dragons under their yoke. Most empires crumble from such heights. In the case of the Targaryens, their slow fall begins when King Viserys breaks with a century of tradition by naming his daughter Rhaenyra heir to the Iron Throne. But when Viserys later fathers a son, the court is shocked when Rhaenyra retains her status as his heir, and seeds of division sow friction across the realm.',
    popularity: 7437.735,
    posterPath: '/z2yahl2uefxDCl0nogcRBstwruJ.jpg',
    firstAirDate: '2022-08-21',
    name: 'House of the Dragon',
    voteAverage: 8.6,
    voteCount: 1702,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];
  const tId = 1;

  blocTest<RecommendationTvSeriesCubit, RecommendationTvSeriesState>(
    'Should emit [Loading, HasData] when data of recommendation TvSeries is gotten successfully.',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return recommendationTvSeriesCubit;
    },
    act: (cubit) => cubit.getData(tId),
    expect: () => [
      RecommendationLoading(),
      RecommendationHasData(tTvSeriesList),
    ],
    verify: (cubit) {
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get recommendation TvSeriess is unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationTvSeriesCubit;
    },
    act: (cubit) => cubit.getData(tId),
    expect: () => [
      RecommendationLoading(),
      const RecommendationError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );
}

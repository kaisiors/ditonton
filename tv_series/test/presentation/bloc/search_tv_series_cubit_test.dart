import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'search_tv_series_cubit_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvSeriesCubit searchTvSeriesCubit;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvSeriesCubit = SearchTvSeriesCubit(mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchTvSeriesCubit.state, SearchTvSeriesEmpty());
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
  const tQuery = 'Spiderman';

  blocTest<SearchTvSeriesCubit, SearchTvSeriesState>(
    'Should emit [Loading, HasData] when data of top rated TvSeries is gotten successfully.',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return searchTvSeriesCubit;
    },
    act: (cubit) => cubit.resultData(tQuery),
    expect: () => [
      SearchTvSeriesLoading(),
      SearchTvSeriesHasData(tTvSeriesList),
    ],
    verify: (cubit) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get top rated TvSeries is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvSeriesCubit;
    },
    act: (cubit) => cubit.resultData(tQuery),
    expect: () => [
      SearchTvSeriesLoading(),
      const SearchTvSeriesError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );
}

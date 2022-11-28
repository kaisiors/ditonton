import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetWatchlistTvSeries>(),
  MockSpec<GetWatchListTvSeriesStatus>(),
  MockSpec<RemoveWatchlistTvSeries>(),
  MockSpec<SaveWatchlistTvSeries>()
])
void main() {
  late WatchlistTvSeriesCubit watchlistTvSeriesCubit;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockGetWatchListTvSeriesStatus mockGetWatchListTvSeriesStatus;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockGetWatchListTvSeriesStatus = MockGetWatchListTvSeriesStatus();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    watchlistTvSeriesCubit = WatchlistTvSeriesCubit(
        mockGetWatchListTvSeriesStatus,
        mockRemoveWatchlistTvSeries,
        mockSaveWatchlistTvSeries,
        mockGetWatchlistTvSeries);
  });

  test('initial state should be empty', () {
    expect(watchlistTvSeriesCubit.state, WatchlistEmpty());
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

  group(
    'Get data Watchlist',
    () {
      blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
        'Should emit [Loading, HasData] when data of watchlist TvSeries is gotten successfully.',
        build: () {
          when(mockGetWatchlistTvSeries.execute())
              .thenAnswer((_) async => Right(tTvSeriesList));
          return watchlistTvSeriesCubit;
        },
        act: (cubit) => cubit.getDataWatchlist(),
        expect: () => [
          WatchlistLoading(),
          WatchlistHasData(tTvSeriesList),
        ],
        verify: (cubit) {
          verify(mockGetWatchlistTvSeries.execute());
        },
      );

      blocTest(
        'Should emit [Loading, Error] when get watchlist TvSeries is unsuccessful',
        build: () {
          when(mockGetWatchlistTvSeries.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistTvSeriesCubit;
        },
        act: (cubit) => cubit.getDataWatchlist(),
        expect: () => [
          WatchlistLoading(),
          const WatchlistError('Server Failure'),
        ],
        verify: (cubit) {
          verify(mockGetWatchlistTvSeries.execute());
        },
      );
    },
  );

  group('Get status watchlist', () {
    blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      'Should emit [IsAddedToWatchlist] when data is true.',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistTvSeriesCubit;
      },
      act: (cubit) => cubit.getStatus(tId),
      expect: () => [const IsAddedToWatchlist(isAddedToWatchlist: true)],
      verify: (cubit) {
        verify(mockGetWatchListTvSeriesStatus.execute(tId));
      },
    );

    blocTest(
      'Should emit [IsAddedToWatchlist] when data is false.',
      build: () {
        when(mockGetWatchListTvSeriesStatus.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistTvSeriesCubit;
      },
      act: (cubit) => cubit.getStatus(tId),
      expect: () => [const IsAddedToWatchlist(isAddedToWatchlist: false)],
      verify: (cubit) {
        verify(mockGetWatchListTvSeriesStatus.execute(tId));
      },
    );
  });

  group('Add to watchlist', () {
    blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      'Should emit [IsAddedToWatchlist] when data of TvSeries is successfully added to watchlist.',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return watchlistTvSeriesCubit;
      },
      act: (cubit) => cubit.addToWatchlist(testTvSeriesDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: true),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest(
      'Should emit [Error] when data of TvSeries is unsuccessful added to watchlist',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesCubit;
      },
      act: (cubit) => cubit.addToWatchlist(testTvSeriesDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: false),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );
  });

  group('Remove from watchlist', () {
    blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      'Should emit [IsAddedToWatchlist] when data of TvSeries is successfully remove from watchlist.',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => const Right(watchlistRemoveSuccessMessage));
        return watchlistTvSeriesCubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: false),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );

    blocTest(
      'Should emit [Error] when data of TvSeries is unsuccessful added to watchlist',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistTvSeriesCubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: true),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
      },
    );
  });
}

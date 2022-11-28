import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetWatchlistMovies>(),
  MockSpec<GetWatchListStatus>(),
  MockSpec<RemoveWatchlist>(),
  MockSpec<SaveWatchlist>()
])
void main() {
  late WatchlistMovieCubit watchlistMovieCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    watchlistMovieCubit = WatchlistMovieCubit(mockGetWatchListStatus,
        mockRemoveWatchlist, mockSaveWatchlist, mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(watchlistMovieCubit.state, WatchlistEmpty());
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovie];
  const tId = 1;

  group(
    'Get data Watchlist',
    () {
      blocTest<WatchlistMovieCubit, WatchlistMovieState>(
        'Should emit [Loading, HasData] when data of watchlist movie is gotten successfully.',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(tMovieList));
          return watchlistMovieCubit;
        },
        act: (cubit) => cubit.getDataWatchlist(),
        expect: () => [
          WatchlistLoading(),
          WatchlistHasData(tMovieList),
        ],
        verify: (cubit) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest(
        'Should emit [Loading, Error] when get watchlist movies is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistMovieCubit;
        },
        act: (cubit) => cubit.getDataWatchlist(),
        expect: () => [
          WatchlistLoading(),
          const WatchlistError('Server Failure'),
        ],
        verify: (cubit) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
    },
  );

  group('Get status watchlist', () {
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'Should emit [IsAddedToWatchlist] when data is true.',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.getStatus(tId),
      expect: () => [const IsAddedToWatchlist(isAddedToWatchlist: true)],
      verify: (cubit) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest(
      'Should emit [IsAddedToWatchlist] when data is false.',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.getStatus(tId),
      expect: () => [const IsAddedToWatchlist(isAddedToWatchlist: false)],
      verify: (cubit) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );
  });

  group('Add to watchlist', () {
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'Should emit [IsAddedToWatchlist] when data of movie is successfully added to watchlist.',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.addToWatchlist(testMovieDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: true),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest(
      'Should emit [Error] when data of movie is unsuccessful added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.addToWatchlist(testMovieDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: false),
      ],
      verify: (cubit) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );
  });

  group('Remove from watchlist', () {
    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'Should emit [IsAddedToWatchlist] when data of movie is successfully remove from watchlist.',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Right(watchlistRemoveSuccessMessage));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: false),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest(
      'Should emit [Error] when data of movie is unsuccessful added to watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return watchlistMovieCubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => [
        const IsAddedToWatchlist(isAddedToWatchlist: true),
      ],
      verify: (cubit) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );
  });
}

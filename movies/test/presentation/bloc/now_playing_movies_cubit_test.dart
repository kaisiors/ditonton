import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'now_playing_movies_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingCubit nowPlayingCubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingCubit = NowPlayingCubit(mockGetNowPlayingMovies);
  });

  test('initial state should be empty', () {
    expect(nowPlayingCubit.state, NowPlayingEmpty());
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

  blocTest<NowPlayingCubit, NowPlayingState>(
    'Should emit [Loading, HasData] when data of now playing movie is gotten successfully.',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingCubit;
    },
    act: (cubit) => cubit.getData(),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get now playing movies is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingCubit;
    },
    act: (cubit) => cubit.getData(),
    expect: () => [
      NowPlayingLoading(),
      const NowPlayingError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}

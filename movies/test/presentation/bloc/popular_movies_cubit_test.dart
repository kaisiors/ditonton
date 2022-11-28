import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'popular_movies_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularCubit popularCubit;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularCubit = PopularCubit(mockGetPopularMovies);
  });

  test('initial state should be empty', () {
    expect(popularCubit.state, PopularEmpty());
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

  blocTest<PopularCubit, PopularState>(
    'Should emit [Loading, HasData] when data of popular movie is gotten successfully.',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return popularCubit;
    },
    act: (cubit) => cubit.getData(),
    expect: () => [
      PopularLoading(),
      PopularHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get popular movies is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularCubit;
    },
    act: (cubit) => cubit.getData(),
    expect: () => [
      PopularLoading(),
      const PopularError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetPopularMovies.execute());
    },
  );
}

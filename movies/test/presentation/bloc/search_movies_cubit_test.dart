import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'search_movies_cubit_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieCubit searchMovieCubit;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMovieCubit = SearchMovieCubit(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(searchMovieCubit.state, SearchMovieEmpty());
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
  const tQuery = 'Spiderman';

  blocTest<SearchMovieCubit, SearchMovieState>(
    'Should emit [Loading, HasData] when data of top rated movie is gotten successfully.',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchMovieCubit;
    },
    act: (cubit) => cubit.resultData(tQuery),
    expect: () => [
      SearchMovieLoading(),
      SearchMovieHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get top rated movies is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchMovieCubit;
    },
    act: (cubit) => cubit.resultData(tQuery),
    expect: () => [
      SearchMovieLoading(),
      const SearchMovieError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'recommendation_movies_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMovieCubit recommendationMovieCubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieCubit =
        RecommendationMovieCubit(mockGetMovieRecommendations);
  });

  test('initial state should be empty', () {
    expect(recommendationMovieCubit.state, RecommendationEmpty());
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

  blocTest<RecommendationMovieCubit, RecommendationMovieState>(
    'Should emit [Loading, HasData] when data of recommendation movie is gotten successfully.',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return recommendationMovieCubit;
    },
    act: (cubit) => cubit.getData(tId),
    expect: () => [
      RecommendationLoading(),
      RecommendationHasData(tMovieList),
    ],
    verify: (cubit) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get recommendation movies is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationMovieCubit;
    },
    act: (cubit) => cubit.getData(tId),
    expect: () => [
      RecommendationLoading(),
      const RecommendationError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}

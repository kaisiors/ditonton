import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movies_cubit_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMovieCubit detailMovieCubit;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieCubit = DetailMovieCubit(mockGetMovieDetail);
  });

  test('initial state should be empty', () {
    expect(detailMovieCubit.state, DetailEmpty());
  });

  const tId = 1;

  blocTest<DetailMovieCubit, DetailMovieState>(
    'Should emit [Loading, HasData] when data of top rated movie is gotten successfully.',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Right(testMovieDetail));
      return detailMovieCubit;
    },
    act: (cubit) => cubit.getDetail(tId),
    expect: () => [
      DetailLoading(),
      const DetailHasData(testMovieDetail),
    ],
    verify: (cubit) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get top rated movies is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMovieCubit;
    },
    act: (cubit) => cubit.getDetail(tId),
    expect: () => [
      DetailLoading(),
      const DetailError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetMovieDetail.execute(tId));
    },
  );
}

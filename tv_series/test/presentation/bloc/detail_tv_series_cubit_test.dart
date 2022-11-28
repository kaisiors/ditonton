import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late DetailTvSeriesCubit detailTvSeriesCubit;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    detailTvSeriesCubit = DetailTvSeriesCubit(mockGetTvSeriesDetail);
  });

  test('initial state should be empty', () {
    expect(detailTvSeriesCubit.state, DetailEmpty());
  });

  const tId = 1;

  blocTest<DetailTvSeriesCubit, DetailTvSeriesState>(
    'Should emit [Loading, HasData] when data of detail Tv Series is gotten successfully.',
    build: () {
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Right(testTvSeriesDetail));
      return detailTvSeriesCubit;
    },
    act: (cubit) => cubit.getDetail(tId),
    expect: () => [
      DetailLoading(),
      const DetailHasData(testTvSeriesDetail),
    ],
    verify: (cubit) {
      verify(mockGetTvSeriesDetail.execute(tId));
    },
  );

  blocTest(
    'Should emit [Loading, Error] when get detail Tv Series is unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailTvSeriesCubit;
    },
    act: (cubit) => cubit.getDetail(tId),
    expect: () => [
      DetailLoading(),
      const DetailError('Server Failure'),
    ],
    verify: (cubit) {
      verify(mockGetTvSeriesDetail.execute(tId));
    },
  );
}

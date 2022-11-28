// Mocks generated by Mockito 5.3.2 from annotations
// in tv_series/test/presentation/bloc/watchlist_tv_series_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:core/core.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series/domain/entities/tv_series.dart' as _i7;
import 'package:tv_series/domain/entities/tv_series_detail.dart' as _i10;
import 'package:tv_series/domain/repositories/tv_series_repository.dart' as _i3;
import 'package:tv_series/domain/usecases/get_watchlist_tv_series.dart' as _i4;
import 'package:tv_series/domain/usecases/get_watchlist_tv_series_status.dart'
    as _i8;
import 'package:tv_series/domain/usecases/remove_watchlist_tv_series.dart'
    as _i9;
import 'package:tv_series/domain/usecases/save_watchlist_tv_series.dart'
    as _i11;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvSeriesRepository_1 extends _i1.SmartFake
    implements _i3.TvSeriesRepository {
  _FakeTvSeriesRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWatchlistTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTvSeries extends _i1.Mock
    implements _i4.GetWatchlistTvSeries {
  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
                _FakeEither_0<_i6.Failure, List<_i7.TvSeries>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
                _FakeEither_0<_i6.Failure, List<_i7.TvSeries>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetWatchListTvSeriesStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvSeriesStatus extends _i1.Mock
    implements _i8.GetWatchListTvSeriesStatus {
  @override
  _i3.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_1(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeTvSeriesRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TvSeriesRepository);
  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
        returnValueForMissingStub: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [RemoveWatchlistTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTvSeries extends _i1.Mock
    implements _i9.RemoveWatchlistTvSeries {
  @override
  _i3.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_1(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeTvSeriesRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TvSeriesRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(
          _i10.TvSeriesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, String>>.value(
                _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
}

/// A class which mocks [SaveWatchlistTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTvSeries extends _i1.Mock
    implements _i11.SaveWatchlistTvSeries {
  @override
  _i3.TvSeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvSeriesRepository_1(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeTvSeriesRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TvSeriesRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(
          _i10.TvSeriesDetail? movie) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [movie],
        ),
        returnValue: _i5.Future<_i2.Either<_i6.Failure, String>>.value(
            _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.Either<_i6.Failure, String>>.value(
                _FakeEither_0<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [movie],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, String>>);
}

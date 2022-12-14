// Mocks generated by Mockito 5.3.2 from annotations
// in tv_series/test/presentation/pages/home_tv_series_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series/presentation/bloc/now_playing/now_playing_cubit.dart'
    as _i2;
import 'package:tv_series/presentation/bloc/popular/popular_cubit.dart' as _i3;
import 'package:tv_series/presentation/bloc/top_rated/top_rated_cubit.dart'
    as _i4;

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

class _FakeNowPlayingTvSeriesState_0 extends _i1.SmartFake
    implements _i2.NowPlayingTvSeriesState {
  _FakeNowPlayingTvSeriesState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePopularTvSeriesState_1 extends _i1.SmartFake
    implements _i3.PopularTvSeriesState {
  _FakePopularTvSeriesState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTopRatedTvSeriesState_2 extends _i1.SmartFake
    implements _i4.TopRatedTvSeriesState {
  _FakeTopRatedTvSeriesState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NowPlayingTvSeriesCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockNowPlayingTvSeriesCubit extends _i1.Mock
    implements _i2.NowPlayingTvSeriesCubit {
  @override
  _i2.NowPlayingTvSeriesState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeNowPlayingTvSeriesState_0(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakeNowPlayingTvSeriesState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.NowPlayingTvSeriesState);
  @override
  _i5.Stream<_i2.NowPlayingTvSeriesState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i2.NowPlayingTvSeriesState>.empty(),
        returnValueForMissingStub:
            _i5.Stream<_i2.NowPlayingTvSeriesState>.empty(),
      ) as _i5.Stream<_i2.NowPlayingTvSeriesState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i5.Future<void> getData() => (super.noSuchMethod(
        Invocation.method(
          #getData,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void emit(_i2.NowPlayingTvSeriesState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i6.Change<_i2.NowPlayingTvSeriesState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [PopularTvSeriesCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockPopularTvSeriesCubit extends _i1.Mock
    implements _i3.PopularTvSeriesCubit {
  @override
  _i3.PopularTvSeriesState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakePopularTvSeriesState_1(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakePopularTvSeriesState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.PopularTvSeriesState);
  @override
  _i5.Stream<_i3.PopularTvSeriesState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i3.PopularTvSeriesState>.empty(),
        returnValueForMissingStub: _i5.Stream<_i3.PopularTvSeriesState>.empty(),
      ) as _i5.Stream<_i3.PopularTvSeriesState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i5.Future<void> getData() => (super.noSuchMethod(
        Invocation.method(
          #getData,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void emit(_i3.PopularTvSeriesState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i6.Change<_i3.PopularTvSeriesState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

/// A class which mocks [TopRatedTvSeriesCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTopRatedTvSeriesCubit extends _i1.Mock
    implements _i4.TopRatedTvSeriesCubit {
  @override
  _i4.TopRatedTvSeriesState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTopRatedTvSeriesState_2(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakeTopRatedTvSeriesState_2(
          this,
          Invocation.getter(#state),
        ),
      ) as _i4.TopRatedTvSeriesState);
  @override
  _i5.Stream<_i4.TopRatedTvSeriesState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i4.TopRatedTvSeriesState>.empty(),
        returnValueForMissingStub:
            _i5.Stream<_i4.TopRatedTvSeriesState>.empty(),
      ) as _i5.Stream<_i4.TopRatedTvSeriesState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i5.Future<void> getData() => (super.noSuchMethod(
        Invocation.method(
          #getData,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void emit(_i4.TopRatedTvSeriesState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i6.Change<_i4.TopRatedTvSeriesState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}

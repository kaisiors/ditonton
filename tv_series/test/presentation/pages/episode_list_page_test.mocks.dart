// Mocks generated by Mockito 5.3.2 from annotations
// in tv_series/test/presentation/pages/episode_list_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series/domain/usecases/get_episode_tv_series.dart' as _i2;
import 'package:tv_series/presentation/bloc/episode/episode_cubit.dart' as _i3;

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

class _FakeGetEpisodeTvSeries_0 extends _i1.SmartFake
    implements _i2.GetEpisodeTvSeries {
  _FakeGetEpisodeTvSeries_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEpisodeTvSeriesState_1 extends _i1.SmartFake
    implements _i3.EpisodeTvSeriesState {
  _FakeEpisodeTvSeriesState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [EpisodeTvSeriesCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockEpisodeTvSeriesCubit extends _i1.Mock
    implements _i3.EpisodeTvSeriesCubit {
  @override
  _i2.GetEpisodeTvSeries get episodeTvSeries => (super.noSuchMethod(
        Invocation.getter(#episodeTvSeries),
        returnValue: _FakeGetEpisodeTvSeries_0(
          this,
          Invocation.getter(#episodeTvSeries),
        ),
        returnValueForMissingStub: _FakeGetEpisodeTvSeries_0(
          this,
          Invocation.getter(#episodeTvSeries),
        ),
      ) as _i2.GetEpisodeTvSeries);
  @override
  _i3.EpisodeTvSeriesState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeEpisodeTvSeriesState_1(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakeEpisodeTvSeriesState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.EpisodeTvSeriesState);
  @override
  _i4.Stream<_i3.EpisodeTvSeriesState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i3.EpisodeTvSeriesState>.empty(),
        returnValueForMissingStub: _i4.Stream<_i3.EpisodeTvSeriesState>.empty(),
      ) as _i4.Stream<_i3.EpisodeTvSeriesState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i4.Future<void> getEpisode(
    int? id,
    int? seasonNumber,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getEpisode,
          [
            id,
            seasonNumber,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void emit(_i3.EpisodeTvSeriesState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i5.Change<_i3.EpisodeTvSeriesState>? change) =>
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
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
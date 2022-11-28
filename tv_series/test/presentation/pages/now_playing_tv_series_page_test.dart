import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'now_playing_tv_series_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NowPlayingTvSeriesCubit>()])
void main() {
  late MockNowPlayingTvSeriesCubit mockNowPlayingTvSeriesCubit;

  setUp(() {
    mockNowPlayingTvSeriesCubit = MockNowPlayingTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesCubit>(
      create: (_) => mockNowPlayingTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowPlayingTvSeriesCubit.state)
        .thenReturn(NowPlayingTvSeriesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingTvSeriesCubit.state)
        .thenReturn(const NowPlayingTvSeriesHasData(<TvSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowPlayingTvSeriesCubit.state)
        .thenReturn(const NowPlayingTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}

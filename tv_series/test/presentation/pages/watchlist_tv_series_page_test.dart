import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WatchlistTvSeriesCubit>()])
void main() {
  late MockWatchlistTvSeriesCubit mockWatchlistTvSeriesCubit;

  setUp(() {
    mockWatchlistTvSeriesCubit = MockWatchlistTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvSeriesCubit>(
      create: (_) => mockWatchlistTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistTvSeriesCubit.state).thenReturn(WatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistTvSeriesCubit.state)
        .thenReturn(WatchlistHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}

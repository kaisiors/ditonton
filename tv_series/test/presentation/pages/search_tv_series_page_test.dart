import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_series_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchTvSeriesCubit>()])
void main() {
  late MockSearchTvSeriesCubit mockSearchTvSeriesCubit;

  setUp(() {
    mockSearchTvSeriesCubit = MockSearchTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvSeriesCubit>(
      create: (_) => mockSearchTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockSearchTvSeriesCubit.state).thenReturn(SearchTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockSearchTvSeriesCubit.state)
        .thenReturn(SearchTvSeriesHasData(testTvSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}

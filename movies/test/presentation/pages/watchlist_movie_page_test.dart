import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WatchlistMovieCubit>()])
void main() {
  late MockWatchlistMovieCubit mockWatchlistMovieCubit;

  setUp(() {
    mockWatchlistMovieCubit = MockWatchlistMovieCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieCubit>(
      create: (_) => mockWatchlistMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockWatchlistMovieCubit.state).thenReturn(WatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockWatchlistMovieCubit.state)
        .thenReturn(WatchlistHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });
}

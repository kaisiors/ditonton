import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchMovieCubit>()])
void main() {
  late MockSearchMovieCubit mockSearchMovieCubit;

  setUp(() {
    mockSearchMovieCubit = MockSearchMovieCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieCubit>(
      create: (_) => mockSearchMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockSearchMovieCubit.state).thenReturn(SearchMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockSearchMovieCubit.state)
        .thenReturn(SearchMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });
}

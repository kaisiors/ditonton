import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'home_movie_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NowPlayingCubit>(),
  MockSpec<PopularCubit>(),
  MockSpec<TopRatedCubit>()
])
void main() {
  late MockNowPlayingCubit mockNowPlayingCubit;
  late MockPopularCubit mockPopularCubit;
  late MockTopRatedCubit mockTopRatedCubit;

  setUp(() {
    mockNowPlayingCubit = MockNowPlayingCubit();
    mockPopularCubit = MockPopularCubit();
    mockTopRatedCubit = MockTopRatedCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingCubit>(
          create: (_) => mockNowPlayingCubit,
        ),
        BlocProvider<PopularCubit>(
          create: (_) => mockPopularCubit,
        ),
        BlocProvider<TopRatedCubit>(
          create: (_) => mockTopRatedCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowPlayingCubit.state).thenReturn(NowPlayingLoading());
    when(mockPopularCubit.state).thenReturn(PopularLoading());
    when(mockTopRatedCubit.state).thenReturn(TopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display now playing, popular, top rated ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingCubit.state)
        .thenReturn(const NowPlayingHasData(<Movie>[]));
    when(mockPopularCubit.state).thenReturn(const PopularHasData(<Movie>[]));
    when(mockTopRatedCubit.state).thenReturn(const TopRatedHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowPlayingCubit.state)
        .thenReturn(const NowPlayingError('Error message'));
    when(mockPopularCubit.state)
        .thenReturn(const PopularError('Error message'));
    when(mockTopRatedCubit.state)
        .thenReturn(const TopRatedError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    expect(textFinder, findsNWidgets(3));
  });
}

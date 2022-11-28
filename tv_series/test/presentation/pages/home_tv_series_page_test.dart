import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'home_tv_series_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NowPlayingTvSeriesCubit>(),
  MockSpec<PopularTvSeriesCubit>(),
  MockSpec<TopRatedTvSeriesCubit>()
])
void main() {
  late MockNowPlayingTvSeriesCubit mockNowPlayingTvSeriesCubit;
  late MockPopularTvSeriesCubit mockPopularTvSeriesCubit;
  late MockTopRatedTvSeriesCubit mockTopRatedTvSeriesCubit;

  setUp(() {
    mockNowPlayingTvSeriesCubit = MockNowPlayingTvSeriesCubit();
    mockPopularTvSeriesCubit = MockPopularTvSeriesCubit();
    mockTopRatedTvSeriesCubit = MockTopRatedTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvSeriesCubit>(
          create: (_) => mockNowPlayingTvSeriesCubit,
        ),
        BlocProvider<PopularTvSeriesCubit>(
          create: (_) => mockPopularTvSeriesCubit,
        ),
        BlocProvider<TopRatedTvSeriesCubit>(
          create: (_) => mockTopRatedTvSeriesCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowPlayingTvSeriesCubit.state)
        .thenReturn(NowPlayingTvSeriesLoading());
    when(mockPopularTvSeriesCubit.state).thenReturn(PopularTvSeriesLoading());
    when(mockTopRatedTvSeriesCubit.state).thenReturn(TopRatedTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const HomeTvSeriesPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display now playing, popular, top rated ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingTvSeriesCubit.state)
        .thenReturn(const NowPlayingTvSeriesHasData(<TvSeries>[]));
    when(mockPopularTvSeriesCubit.state)
        .thenReturn(const PopularTvSeriesHasData(<TvSeries>[]));
    when(mockTopRatedTvSeriesCubit.state)
        .thenReturn(const TopRatedTvSeriesHasData(<TvSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const HomeTvSeriesPage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowPlayingTvSeriesCubit.state)
        .thenReturn(const NowPlayingTvSeriesError('Error message'));
    when(mockPopularTvSeriesCubit.state)
        .thenReturn(const PopularTvSeriesError('Error message'));
    when(mockTopRatedTvSeriesCubit.state)
        .thenReturn(const TopRatedTvSeriesError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const HomeTvSeriesPage()));

    expect(textFinder, findsNWidgets(3));
  });
}

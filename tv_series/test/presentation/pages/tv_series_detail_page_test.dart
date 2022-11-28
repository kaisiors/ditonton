import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DetailTvSeriesCubit>(),
  MockSpec<RecommendationTvSeriesCubit>(),
  MockSpec<WatchlistTvSeriesCubit>()
])
void main() {
  late MockDetailTvSeriesCubit mockDetailTvSeriesCubit;
  late MockRecommendationTvSeriesCubit mockRecommendationTvSeriesCubit;
  late MockWatchlistTvSeriesCubit mockWatchlistTvSeriesCubit;

  setUp(
    () {
      mockDetailTvSeriesCubit = MockDetailTvSeriesCubit();
      mockRecommendationTvSeriesCubit = MockRecommendationTvSeriesCubit();
      mockWatchlistTvSeriesCubit = MockWatchlistTvSeriesCubit();
    },
  );

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvSeriesCubit>(
          create: (_) => mockDetailTvSeriesCubit,
        ),
        BlocProvider<RecommendationTvSeriesCubit>(
          create: (_) => mockRecommendationTvSeriesCubit,
        ),
        BlocProvider<WatchlistTvSeriesCubit>(
          create: (_) => mockWatchlistTvSeriesCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when TV Series not added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailTvSeriesCubit.state)
        .thenReturn(const DetailHasData(testTvSeriesDetail));
    when(mockRecommendationTvSeriesCubit.state)
        .thenReturn(const RecommendationHasData(<TvSeries>[]));
    when(mockWatchlistTvSeriesCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when TV Series is added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailTvSeriesCubit.state)
        .thenReturn(const DetailHasData(testTvSeriesDetail));
    when(mockRecommendationTvSeriesCubit.state)
        .thenReturn(const RecommendationHasData(<TvSeries>[]));
    when(mockWatchlistTvSeriesCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when TV Series is added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailTvSeriesCubit.state)
        .thenReturn(const DetailHasData(testTvSeriesDetail));
    when(mockRecommendationTvSeriesCubit.state)
        .thenReturn(const RecommendationHasData(<TvSeries>[]));
    when(mockWatchlistTvSeriesCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: false));
    when(mockWatchlistTvSeriesCubit.message).thenReturn('Added to Watchlist');

    final watchlistButton = find.byKey(const Key('add_watchlist'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when TV Series is added to watchlist failed',
      (WidgetTester tester) async {
    when(mockDetailTvSeriesCubit.state)
        .thenReturn(const DetailHasData(testTvSeriesDetail));
    when(mockRecommendationTvSeriesCubit.state)
        .thenReturn(const RecommendationHasData(<TvSeries>[]));
    when(mockWatchlistTvSeriesCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: false));
    when(mockWatchlistTvSeriesCubit.message).thenReturn('Failed');

    final watchlistButton = find.byKey(const Key('add_watchlist'));

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}

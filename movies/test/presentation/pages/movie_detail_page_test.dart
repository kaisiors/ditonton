import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DetailMovieCubit>(),
  MockSpec<RecommendationMovieCubit>(),
  MockSpec<WatchlistMovieCubit>()
])
void main() {
  late MockDetailMovieCubit mockDetailMovieCubit;
  late MockRecommendationMovieCubit mockRecommendationMovieCubit;
  late MockWatchlistMovieCubit mockWatchlistMovieCubit;

  setUp(() {
    mockDetailMovieCubit = MockDetailMovieCubit();
    mockRecommendationMovieCubit = MockRecommendationMovieCubit();
    mockWatchlistMovieCubit = MockWatchlistMovieCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieCubit>(
          create: (_) => mockDetailMovieCubit,
        ),
        BlocProvider<RecommendationMovieCubit>(
          create: (_) => mockRecommendationMovieCubit,
        ),
        BlocProvider<WatchlistMovieCubit>(
          create: (_) => mockWatchlistMovieCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailMovieCubit.state)
        .thenReturn(const DetailHasData(testMovieDetail));
    when(mockRecommendationMovieCubit.state)
        .thenReturn(const RecommendationHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockDetailMovieCubit.state)
        .thenReturn(const DetailHasData(testMovieDetail));
    when(mockRecommendationMovieCubit.state)
        .thenReturn(const RecommendationHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockDetailMovieCubit.state)
        .thenReturn(const DetailHasData(testMovieDetail));
    when(mockRecommendationMovieCubit.state)
        .thenReturn(const RecommendationHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: false));
    when(mockWatchlistMovieCubit.message).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockDetailMovieCubit.state)
        .thenReturn(const DetailHasData(testMovieDetail));
    when(mockRecommendationMovieCubit.state)
        .thenReturn(const RecommendationHasData(<Movie>[]));
    when(mockWatchlistMovieCubit.state)
        .thenReturn(const IsAddedToWatchlist(isAddedToWatchlist: false));
    when(mockWatchlistMovieCubit.message).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'episode_list_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<EpisodeTvSeriesCubit>()])
void main() {
  late MockEpisodeTvSeriesCubit mockEpisodeTvSeriesCubit;

  setUp(() {
    mockEpisodeTvSeriesCubit = MockEpisodeTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<EpisodeTvSeriesCubit>(
      create: (_) => mockEpisodeTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockEpisodeTvSeriesCubit.state).thenReturn(EpisodeLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const EpisodeListPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockEpisodeTvSeriesCubit.state)
        .thenReturn(const EpisodeHasData(<Episode>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const EpisodeListPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockEpisodeTvSeriesCubit.state)
        .thenReturn(const EpisodeError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const EpisodeListPage(
      id: 1,
      seasonNumber: 1,
    )));

    expect(textFinder, findsOneWidget);
  });
}

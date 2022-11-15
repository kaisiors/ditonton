import 'package:ditonton/common/arguments.dart';
import 'package:ditonton/presentation/pages/episode_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Page should display Tab when page is open',
      (WidgetTester tester) async {
    final tabFinder = find.byKey(Key('tab'));

    await tester.pumpWidget(_makeTestableWidget(EpisodePage(
      argument: EpisodeArgument(id: 1, seasons: []),
    )));

    expect(tabFinder, findsOneWidget);
  });
}

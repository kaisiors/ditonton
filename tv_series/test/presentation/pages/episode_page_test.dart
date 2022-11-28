import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Page should display Tab when page is open',
      (WidgetTester tester) async {
    final tabFinder = find.byKey(const Key('tab'));

    await tester.pumpWidget(makeTestableWidget(EpisodePage(
      argument: EpisodeArgument(id: 1, seasons: []),
    )));

    expect(tabFinder, findsOneWidget);
  });
}

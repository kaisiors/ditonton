import 'package:ditonton/main.dart' as app;
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  group('Test App', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Movie Home', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final nowPlaying = find.byKey(Key('now_playing'));
      final popular = find.byKey(Key('popular'));
      final topRated = find.byKey(Key('top_rated'));

      expect(nowPlaying, findsOneWidget);
      expect(popular, findsOneWidget);
      expect(topRated, findsOneWidget);
    });
  });
}

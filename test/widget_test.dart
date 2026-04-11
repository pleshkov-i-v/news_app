// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:news_app/core/di/injection.dart';
import 'package:news_app/news_app.dart';

void main() {
  setUp(configureDependencies);

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('Home shows News tab and bottom navigation', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NewsApp());
    await tester.pump();

    expect(find.text('News'), findsWidgets);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}

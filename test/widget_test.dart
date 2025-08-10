// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:igviewer/main.dart';

void main() {
  testWidgets('App instantiates without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Pump a frame to let the initial UI render
    await tester.pump();

    // Verify that we have a MaterialApp (basic app structure)
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verify that we have a Scaffold
    expect(find.byType(Scaffold), findsOneWidget);
  });
}

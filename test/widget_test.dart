import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase_app/main.dart';

void main() {
  testWidgets('App starts with Splash Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: ToDoApp()));

    // Verify that the splash screen text is present.
    expect(find.text('ToDo App'), findsOneWidget);
  });
}

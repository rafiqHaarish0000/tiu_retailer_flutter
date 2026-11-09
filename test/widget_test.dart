import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tiu_retailer_flutter/main.dart';

void main() {
  testWidgets('renders the branded splash screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TopitupRetailerApp());

    expect(find.text('Convenience at your fingertips'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Dispose the tree so the splash navigation timer is cancelled.
    await tester.pumpWidget(const SizedBox.shrink());
  });
}

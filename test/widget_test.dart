import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tiu_retailer_flutter/main.dart';
import 'package:tiu_retailer_flutter/ui/auth/screens/login_screen.dart';

void main() {
  testWidgets('launches to the retailer login screen', (
    WidgetTester tester,
  ) async {
    // The default test font (Ahem) inflates text width, which overflows the
    // fixed-width reCAPTCHA row on the login screen. Collect layout errors so
    // they do not mask the assertions below.
    final errors = <FlutterErrorDetails>[];
    final previousOnError = FlutterError.onError;
    FlutterError.onError = errors.add;
    addTearDown(() => FlutterError.onError = previousOnError);

    await tester.pumpWidget(const TopitupRetailerApp());
    await tester.pump();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Retailer'), findsOneWidget);
    expect(find.text('Supplier'), findsOneWidget);

    final unexpected = errors.where(
      (details) => !details.exceptionAsString().contains('overflowed'),
    );
    expect(unexpected, isEmpty);
  });
}

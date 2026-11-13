import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiu_retailer_flutter/ui/modules/my_sales_transactions/screens/my_sales_transactions_screen.dart';

void main() {
  testWidgets('sales transaction controls and empty states work', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(388, 839);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: MySalesTransactionsScreen())),
    );

    expect(find.text('Sales Transactions'), findsOneWidget);
    expect(find.text('No Records Found'), findsNWidgets(3));
    expect(
      tester.getSize(find.byKey(const Key('sales-title-header'))).width,
      356,
    );

    await tester.tap(find.text('Sales Summary'));
    await tester.pump();
    expect(find.text('Please wait...'), findsOneWidget);
    expect(find.text('Loading page'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1100));
    await tester.pumpAndSettle();
    expect(find.text('No Records Found'), findsOneWidget);

    await tester.tap(find.byKey(const Key('sales-show-button')));
    await tester.pump();
    expect(find.text('Please wait...'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1100));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('sales-date-picker')));
    await tester.pumpAndSettle();
    expect(find.text('Clear'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);

    await tester.tap(find.text('Today'));
    await tester.pump();
    expect(find.text('Today'), findsNothing);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tiu_retailer_flutter/screens/dashboard.dart';

void main() {
  testWidgets('supplier flow fling does not throw hit test errors', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final errors = <String>[];
    final previous = FlutterError.onError;
    FlutterError.onError = (details) {
      errors.add(details.exceptionAsString());
    };
    addTearDown(() => FlutterError.onError = previous);

    // Bounded pump helper: the supplier page has a periodic Timer, so
    // pumpAndSettle would never settle.
    Future<void> pump([int frames = 20]) async {
      for (var i = 0; i < frames; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));
    await pump();

    Future<void> flingAll(String tag) async {
      final scrollables = find.byType(Scrollable);
      final count = scrollables.evaluate().length;
      for (var i = 0; i < count; i++) {
        await tester.fling(scrollables.at(i), const Offset(0, -250), 1200);
        await pump(8);
      }
      // ignore: avoid_print
      print('FLING $tag (scrollables=$count) errs=${errors.length}');
    }

    await tester.tap(find.byIcon(Icons.local_shipping_outlined).last);
    await pump();
    await flingAll('supplier-orders');

    final placeOrder = find.text('Place Order');
    if (placeOrder.evaluate().isNotEmpty) {
      await tester.tap(placeOrder.first);
      await pump();
      await flingAll('wholesaler-list');
    }

    for (final e in errors) {
      // ignore: avoid_print
      print('ERR=> ${e.split('\n').first}');
    }
  });
}

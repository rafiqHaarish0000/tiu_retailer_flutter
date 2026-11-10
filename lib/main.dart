import 'dart:async';

import 'package:flutter/material.dart';

import 'screens/login.dart';
import 'theme/app_theme.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  // Keep Android's animated launch icon visible briefly while Flutter prepares
  // the login page, then let Flutter draw its first frame.
  binding.deferFirstFrame();
  Timer(const Duration(milliseconds: 1000), binding.allowFirstFrame);
  runApp(const TopitupRetailerApp());
}

class TopitupRetailerApp extends StatelessWidget {
  const TopitupRetailerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Topitup Retailer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      home: const LoginScreen(),
    );
  }
}

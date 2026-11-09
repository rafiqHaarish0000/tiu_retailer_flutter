import 'package:flutter/material.dart';

import 'screens/splash.dart';
import 'theme/app_theme.dart';

void main() => runApp(const TopitupRetailerApp());

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
      home: const SplashScreen(),
    );
  }
}

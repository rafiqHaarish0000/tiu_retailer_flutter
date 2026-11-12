import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/auth/screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: const [SystemUiOverlay.top],
  );
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

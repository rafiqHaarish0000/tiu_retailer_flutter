import 'package:flutter/material.dart';

void main() => runApp(const TopitupRetailerApp());

class TopitupRetailerApp extends StatelessWidget {
  const TopitupRetailerApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandRed = Color(0xFFC8102E);

    return MaterialApp(
      title: 'Topitup Retailer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: brandRed),
        useMaterial3: true,
      ),
      home: const RetailerHomePage(),
    );
  }
}

class RetailerHomePage extends StatelessWidget {
  const RetailerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/topitup_logo.png',
                  width: 280,
                  fit: BoxFit.contain,
                  semanticLabel: 'Top it Up logo',
                ),
                const SizedBox(height: 24),
                Text(
                  'Retailer',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFFC8102E),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

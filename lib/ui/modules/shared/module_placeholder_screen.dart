import 'package:flutter/material.dart';

class ModulePlaceholderScreen extends StatelessWidget {
  const ModulePlaceholderScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title\nComing Soon',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF1E2A40),
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.5,
        ),
      ),
    );
  }
}

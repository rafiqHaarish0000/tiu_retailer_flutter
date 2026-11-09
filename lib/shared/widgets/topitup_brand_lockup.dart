import 'package:flutter/material.dart';

class TopitupBrandLockup extends StatelessWidget {
  const TopitupBrandLockup({required this.width, super.key});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/topitup_logo.png',
          width: width,
          fit: BoxFit.contain,
          semanticLabel: 'Top it Up logo',
        ),
        const SizedBox(height: 6),
        Text(
          'Convenience at your fingertips',
          style: TextStyle(
            color: const Color(0xFF343434),
            fontSize: width * 0.07,
            shadows: const [
              Shadow(
                color: Color(0x33000000),
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

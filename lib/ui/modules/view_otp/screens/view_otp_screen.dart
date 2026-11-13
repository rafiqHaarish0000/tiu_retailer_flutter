import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class ViewOtpScreen extends StatefulWidget {
  const ViewOtpScreen({this.onBack, super.key});

  final VoidCallback? onBack;

  @override
  State<ViewOtpScreen> createState() => _ViewOtpScreenState();
}

class _ViewOtpScreenState extends State<ViewOtpScreen> {
  static const _muted = Color(0xFF7287A6);
  static const _codes = ['130585', '847216', '592704', '316928'];

  int _codeIndex = 0;

  Future<void> _refreshCode() async {
    unawaited(
      showGeneralDialog<void>(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        barrierLabel: 'Loading',
        barrierColor: const Color(0x99708091),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _OtpLoadingDialog(),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    setState(() => _codeIndex = (_codeIndex + 1) % _codes.length);
  }

  void _back() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF5F8FC),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          children: [
            _buildTitleBar(),
            const SizedBox(height: 16),
            _buildOtpCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE5EBF1)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D1E2A40),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Text(
            'View OTP',
            style: TextStyle(
              color: Color(0xFF11182B),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Positioned(
            left: 8,
            child: _OtpIconButton(
              icon: Icons.arrow_back,
              color: const Color(0xFF28415C),
              background: const Color(0xFFF0F6FA),
              onTap: _back,
            ),
          ),
          Positioned(
            right: 8,
            child: _OtpIconButton(
              icon: Icons.home_outlined,
              color: AppColors.brandRed,
              background: const Color(0xFFFFF0F2),
              onTap: _back,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpCard() {
    return Container(
      width: double.infinity,
      height: 344,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE5ED)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1E2A40),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFC8102E), Color(0xFFE87500)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x33C8102E),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_outline,
              color: Colors.white,
              size: 29,
            ),
          ),
          const SizedBox(height: 19),
          const Text(
            'Your One-Time Password',
            style: TextStyle(
              color: Color(0xFF11182B),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Use this code to confirm transactions on your device.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 20),
          Container(
            width: 167,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFD45B), width: 2),
            ),
            child: Text(
              _codes[_codeIndex],
              style: const TextStyle(
                color: AppColors.brandRed,
                fontSize: 30,
                letterSpacing: 7,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RoundAction(
                icon: Icons.sync,
                color: const Color(0xFF1D9D6C),
                onTap: _refreshCode,
              ),
              const SizedBox(width: 16),
              _RoundAction(
                icon: Icons.arrow_back,
                color: AppColors.brandRed,
                onTap: _back,
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _OtpIconButton extends StatelessWidget {
  const _OtpIconButton({
    required this.icon,
    required this.color,
    required this.background,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: color, size: 21),
        ),
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      elevation: 5,
      shadowColor: color.withValues(alpha: .30),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 55,
          height: 55,
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

class _OtpLoadingDialog extends StatelessWidget {
  const _OtpLoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: const SizedBox(
          width: 206,
          height: 161,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Color(0xFF165DFF),
                  backgroundColor: Color(0xFFDCEAFF),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Please wait...',
                style: TextStyle(
                  color: Color(0xFF0E2442),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Loading page',
                style: TextStyle(color: Color(0xFF7385A1), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

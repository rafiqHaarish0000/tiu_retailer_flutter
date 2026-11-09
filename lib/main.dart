import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'theme/app_colors.dart';
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Center(child: TopitupBrandLockup(width: 280)),
    );
  }
}

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // Placeholder values for the future local/demo authentication flow.
  static const defaultUsername = 'retailer';
  static const defaultPassword = 'retailer123';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _captchaChecked = false;
  bool _isRetailer = true;

  // Integration placeholders for the backend and local database.
  // These intentionally contain no implementation and are not connected to UI.
  Future<void> callLoginApi() async {}
  Future<void> callDatabase() async {}
  void onLoginButtonPressed() {}

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final widthScale = constraints.maxWidth / 746;
            final heightScale = constraints.maxHeight / 1100;
            final scale = math
                .min(widthScale, heightScale)
                .clamp(0.1, 1.0)
                .toDouble();
            final sideInset = constraints.maxWidth < 500 ? 16.0 : 32.0 * scale;
            final panelPadding = 54.0 * scale;

            return Padding(
              padding: EdgeInsets.only(
                top: 24 * scale,
                left: sideInset,
                right: sideInset,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TopitupBrandLockup(width: 288 * scale),
                      SizedBox(height: 50 * scale),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: panelPadding - 16 * scale,
                          vertical: panelPadding,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(34 * scale),
                          border: Border.all(
                            color: const Color(0xFFE0E8F1),
                            width: 1.5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0B253B53),
                              blurRadius: 28,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildRoleSelector(scale),
                            SizedBox(height: 34 * scale),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16 * scale,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildFieldLabel('USERNAME', scale),
                                  SizedBox(height: 10 * scale),
                                  _buildUsernameField(scale),
                                  SizedBox(height: 32 * scale),
                                  _buildFieldLabel('PASSWORD', scale),
                                  SizedBox(height: 10 * scale),
                                  _buildPasswordField(scale),
                                  SizedBox(height: 40 * scale),
                                  Center(child: _buildCaptcha(scale)),
                                  SizedBox(height: 34 * scale),
                                  _buildLoginButton(scale),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40 * scale),
                      Text(
                        '© 2026 Top it Up. E&OE. All Rights Reserved',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF91A5BF),
                          fontSize: 22 * scale,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoleSelector(double scale) {
    return Container(
      padding: EdgeInsets.all(10 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4F9),
        borderRadius: BorderRadius.circular(24 * scale),
        border: Border.all(color: const Color(0xFFDDE6F0), width: 2),
      ),
      child: Row(
        children: [
          _roleButton(
            label: 'Retailer',
            icon: Icons.storefront_outlined,
            selected: _isRetailer,
            scale: scale,
            onTap: () => setState(() => _isRetailer = true),
          ),
          _roleButton(
            label: 'Supplier',
            icon: Icons.local_shipping_outlined,
            selected: !_isRetailer,
            scale: scale,
            onTap: () => setState(() => _isRetailer = false),
          ),
        ],
      ),
    );
  }

  Widget _roleButton({
    required String label,
    required IconData icon,
    required bool selected,
    required double scale,
    required VoidCallback onTap,
  }) {
    final color = selected ? const Color(0xFFC71920) : const Color(0xFF657A96);
    return Expanded(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18 * scale),
        child: InkWell(
          borderRadius: BorderRadius.circular(18 * scale),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 72 * scale,
            decoration: BoxDecoration(
              color: selected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(18 * scale),
              boxShadow: selected
                  ? const [
                      BoxShadow(
                        color: Color(0x1A31445A),
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 28 * scale, color: color),
                SizedBox(width: 12 * scale),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 25 * scale,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text, double scale) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF34445C),
        fontSize: 24 * scale,
        letterSpacing: 0.4,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildUsernameField(double scale) {
    return _buildInputFrame(
      scale: scale,
      child: TextField(
        controller: _usernameController,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: const Color(0xFF34445C), fontSize: 27 * scale),
        decoration: InputDecoration(
          hintText: 'Enter your username or terminal ID',
          hintStyle: TextStyle(
            color: const Color(0xFF91A5BF),
            fontSize: 27 * scale,
          ),
          prefixIcon: Icon(Icons.person_outline, size: 34 * scale),
          prefixIconColor: const Color(0xFF91A5BF),
          prefixIconConstraints: BoxConstraints(
            minWidth: 72 * scale,
            minHeight: 48 * scale,
          ),
          filled: false,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10 * scale),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPasswordField(double scale) {
    return _buildInputFrame(
      scale: scale,
      child: TextField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: const Color(0xFF34445C), fontSize: 27 * scale),
        decoration: InputDecoration(
          hintText: 'Enter your secret password',
          hintStyle: TextStyle(
            color: const Color(0xFF91A5BF),
            fontSize: 27 * scale,
          ),
          prefixIcon: Icon(Icons.lock_outline, size: 32 * scale),
          prefixIconColor: const Color(0xFF91A5BF),
          suffixIconColor: const Color(0xFF91A5BF),
          prefixIconConstraints: BoxConstraints(
            minWidth: 72 * scale,
            minHeight: 48 * scale,
          ),
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(
              minWidth: 56 * scale,
              minHeight: 48 * scale,
            ),
            tooltip: _obscurePassword ? 'Show password' : 'Hide password',
            onPressed: () => setState(() {
              _obscurePassword = !_obscurePassword;
            }),
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 30 * scale,
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 64 * scale,
            minHeight: 48 * scale,
          ),
          filled: false,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10 * scale),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildInputFrame({required double scale, required Widget child}) {
    return Container(
      height: 96 * scale,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 4 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(23 * scale),
        border: Border.all(color: const Color(0xFFC9D5E3), width: 2 * scale),
      ),
      child: child,
    );
  }

  Widget _buildCaptcha(double scale) {
    return SizedBox(
      width: 516 * scale,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 16 * scale),
        decoration: const BoxDecoration(
          color: Color(0xFFFAFAFA),
          border: Border(
            top: BorderSide(color: Color(0xFFD8D8D8)),
            bottom: BorderSide(color: Color(0xFFD8D8D8)),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2 * scale),
              child: Text(
                'This reCAPTCHA is for testing purposes only. Please report to the site admin if you are seeing this.',
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'serif',
                  fontSize: 14 * scale,
                  height: 1.3,
                ),
              ),
            ),
            SizedBox(height: 4 * scale),
            Row(
              children: [
                SizedBox(width: 8 * scale),
                InkWell(
                  onTap: () =>
                      setState(() => _captchaChecked = !_captchaChecked),
                  child: Container(
                    width: 50 * scale,
                    height: 50 * scale,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFF555555),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: _captchaChecked
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 38 * scale,
                          )
                        : null,
                  ),
                ),
                SizedBox(width: 18 * scale),
                Text(
                  "I'm not a robot",
                  style: TextStyle(color: Colors.black, fontSize: 24 * scale),
                ),
                const Spacer(),
                Column(
                  children: [
                    Icon(
                      Icons.sync,
                      color: const Color(0xFF4778C7),
                      size: 45 * scale,
                    ),
                    Text(
                      'reCAPTCHA',
                      style: TextStyle(
                        color: const Color(0xFF555555),
                        fontSize: 16 * scale,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 12 * scale),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(double scale) {
    return SizedBox(
      height: 96 * scale,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24 * scale),
          gradient: const LinearGradient(
            colors: [Color(0xFFC3161C), Color(0xFFEA0000), Color(0xFFE87500)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33C3161C),
              blurRadius: 26,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24 * scale),
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29 * scale,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 18 * scale),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 32 * scale,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

part of '../../dashboard/screens/dashboard_screen.dart';

class _PayToWholesalerPage extends StatelessWidget {
  const _PayToWholesalerPage({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 16, 25, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWholesalerPicker(),
          const SizedBox(height: 18),
          _buildServicesHeader(),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(6, 16, 6, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'QUICK ACTIONS',
                  style: TextStyle(
                    color: Color(0xFF1F5BE5),
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'What would you like to do?',
                  style: TextStyle(
                    color: Color(0xFF17243B),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.02,
                  children: const [
                    _PaymentActionCard(
                      title: 'Pay Wholesaler',
                      subtitle: 'Make a payment to your wholesaler',
                      icon: Icons.storefront_outlined,
                      iconColor: Color(0xFF5EA4FF),
                      accentColor: Color(0xFF2E6BFF),
                    ),
                    _PaymentActionCard(
                      title: 'Scan to Pay',
                      subtitle: 'Scan a QR code to make a payment',
                      icon: Icons.qr_code_2,
                      iconColor: Color(0xFFE51B2E),
                      accentColor: Color(0xFF7D3BFF),
                    ),
                    _PaymentActionCard(
                      title: 'Payment History',
                      subtitle: 'View your previous payment requests',
                      icon: Icons.payments_outlined,
                      iconColor: Color(0xFF1F96C6),
                      accentColor: Color(0xFF1DA97E),
                    ),
                    _PaymentActionCard(
                      title: 'Payment Summary',
                      subtitle: 'View your payment summary and details',
                      icon: Icons.assignment_outlined,
                      iconColor: Color(0xFF172B58),
                      accentColor: Color(0xFFFF6200),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                const Divider(color: Color(0xFFE1E8F0), height: 1),
                const SizedBox(height: 15),
                _PageActionButton(
                  label: 'Back',
                  backgroundColor: const Color(0xFFE0E7F0),
                  foregroundColor: const Color(0xFF52647D),
                  icon: Icons.arrow_back,
                  onPressed: onBack,
                ),
                const SizedBox(height: 12),
                _PageActionButton(
                  label: 'Refresh',
                  backgroundColor: const Color(0xFF2860E7),
                  foregroundColor: Colors.white,
                  icon: Icons.refresh,
                  onPressed: () {},
                ),
                const SizedBox(height: 34),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWholesalerPicker() {
    return Container(
      height: 286,
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x101E3854),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              _SectionIcon(icon: Icons.storefront_outlined),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wholesalers',
                      style: TextStyle(
                        color: Color(0xFF17243B),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Select a wholesaler to continue',
                      style: TextStyle(color: Color(0xFF6E83A2), fontSize: 11),
                    ),
                  ],
                ),
              ),
              _CountBadge(),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 150,
            height: 187,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(14, 17, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFFDCE4ED)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x101E3854),
                        blurRadius: 12,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8FBF1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Color(0xFF18B86D),
                              size: 7,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'AVAILABLE',
                              style: TextStyle(
                                color: Color(0xFF168251),
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 9),
                      Center(
                        child: Container(
                          width: 51,
                          height: 51,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDEAFF),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'TW',
                              style: TextStyle(
                                color: Color(0xFF285BE0),
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tobacco Wholesal...',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF17243B),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF1FC),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xFF3F7CF0),
                              size: 15,
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                'Church Road,\nHermanus...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF6E83A2),
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 40,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5FB),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF9AAAC0),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesHeader() {
    return Container(
      height: 89,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D4E83), Color(0xFF2691C8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: const Row(
        children: [
          _SectionIcon(icon: Icons.credit_card_outlined),
          SizedBox(width: 13),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Select a payment option to continue',
                style: TextStyle(color: Color(0xFFD9EEFB), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionIcon extends StatelessWidget {
  const _SectionIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF3A72A0).withValues(alpha: .75),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: .32)),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 39,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD4E2FA)),
      ),
      child: Center(
        child: Container(
          width: 23,
          height: 23,
          decoration: const BoxDecoration(
            color: Color(0xFF2B65E6),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentActionCard extends StatelessWidget {
  const _PaymentActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5FF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x141D4F91),
            blurRadius: 9,
            offset: Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(height: 4, color: accentColor),
          const SizedBox(height: 18),
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .72),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF17243B),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF8092AF),
                fontSize: 10,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageActionButton extends StatelessWidget {
  const _PageActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .22),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(icon, size: 16),
        ),
        label: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      ),
    );
  }
}

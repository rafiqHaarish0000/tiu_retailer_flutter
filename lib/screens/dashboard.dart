import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;
  String? _activeService;

  void _openComingSoon(String title) {
    setState(() {
      _activeService = title;
      _selectedTab = 0;
    });
  }

  static const _services = [
    _Service(
      'Transfer to Wallet',
      'Float Transfer',
      Icons.account_balance_wallet_outlined,
      Color(0xFFFFF8DE),
      Color(0xFFE57800),
    ),
    _Service(
      'Transfer to Stores',
      'Inter-store Shift',
      Icons.storefront_outlined,
      Color(0xFFFFEFF0),
      AppColors.brandRed,
    ),
    _Service(
      'Top It Up Voucher',
      'Prepaid PINs',
      Icons.confirmation_number_outlined,
      Color(0xFFF5ECFF),
      Color(0xFF8B25F5),
    ),
    _Service(
      'Pay Suppliers',
      'Vendor Payout',
      Icons.local_shipping_outlined,
      Color(0xFFEAF3FF),
      Color(0xFF1769E8),
    ),
    _Service(
      'Wholesaler Payments',
      'Settlements Portal',
      Icons.domain_outlined,
      Color(0xFFFFE8E8),
      Color(0xFFE13636),
    ),
    _Service(
      'Account Payments',
      'Instant EFT',
      Icons.account_balance_outlined,
      Color(0xFFFFF8DE),
      Color(0xFFB56A00),
    ),
    _Service(
      'My Sales Transactions',
      'Terminal Ledger',
      Icons.desktop_windows_outlined,
      Color(0xFFE5FAFC),
      Color(0xFF0087A0),
    ),
    _Service(
      'Commissions & Invoices',
      'Tax & Rebates',
      Icons.picture_as_pdf_outlined,
      Color(0xFFFFF2E8),
      Color(0xFFE44600),
    ),
    _Service(
      'Financial Transactions',
      'Cleared Ledger',
      Icons.swap_horiz,
      Color(0xFFE5FAF1),
      Color(0xFF168A63),
    ),
    _Service(
      'Sales & Shift Reports',
      'Daily Cashup',
      Icons.bar_chart_outlined,
      Color(0xFFE8FAF6),
      Color(0xFF159B78),
    ),
    _Service(
      'Deposit History',
      'Bank Slips',
      Icons.account_balance_wallet_outlined,
      Color(0xFFFFF8DE),
      Color(0xFFB55A00),
    ),
    _Service(
      'Money Transfers',
      'Remittance',
      Icons.public_outlined,
      Color(0xFFE8FAEF),
      Color(0xFF15934B),
    ),
    _Service(
      'POS Users',
      'Cashier Access',
      Icons.groups_outlined,
      Color(0xFFECEBFF),
      Color(0xFF4A3FE2),
    ),
    _Service(
      'Website Users',
      'Admin Roles',
      Icons.person_add_alt_1_outlined,
      Color(0xFFE8F4FF),
      Color(0xFF0078BA),
    ),
    _Service(
      'My Devices',
      'Terminals',
      Icons.phone_android_outlined,
      Color(0xFFEDF2F7),
      Color(0xFF52677D),
    ),
    _Service(
      'View OTP',
      'Security Token',
      Icons.password_outlined,
      Color(0xFFFFF8DE),
      Color(0xFFE17B00),
    ),
    _Service(
      'Supplier Orders',
      'Stock Dispatch',
      Icons.inventory_2_outlined,
      Color(0xFFFFEAF0),
      Color(0xFFD71948),
    ),
    _Service(
      'Top It Up Banking Details',
      'EFT Clearing Info',
      Icons.account_balance_outlined,
      Color(0xFFFFF8DE),
      Color(0xFFB55A00),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _activeService != null
                  ? _buildTabComingSoon(_activeService!)
                  : _selectedTab == 0
                  ? _buildServiceGrid()
                  : _selectedTab == 1
                  ? const _PayToWholesalerPage()
                  : _buildTabComingSoon(_tabTitle(_selectedTab)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildServiceGrid() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ServiceCard(
                service: _services[index],
                onTap: () => _openComingSoon(_services[index].title),
              ),
              childCount: _services.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.92,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabComingSoon(String title) {
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

  String _tabTitle(int index) {
    switch (index) {
      case 1:
        return 'Pay to Wholesaler';
      case 2:
        return 'Quick Transfer';
      case 3:
        return 'Balance';
      case 4:
        return 'Account';
      default:
        return 'Home';
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 7),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE1E8F0))),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.brandRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Top\nit Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: .9,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F6FA),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: const Color(0xFFD9E2EC)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Demo Test Account [PTG999]',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Icon(Icons.check, color: Color(0xFF159B78), size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _headerButton(
                Icons.credit_card_outlined,
                const Color(0xFF3F43EE),
                onTap: () => _showAccountSummary(context),
              ),
              const SizedBox(width: 6),
              _headerButton(
                Icons.power_settings_new,
                AppColors.brandRed,
                onTap: () => _showLogoutConfirmation(context),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            '#Stores in Group: 1',
            style: TextStyle(color: Color(0xFF8498B6), fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _headerButton(IconData icon, Color color, {VoidCallback? onTap}) {
    final button = Container(
      width: 36,
      height: 34,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFFDDE5EE)),
      ),
      child: Icon(icon, color: color, size: 19),
    );

    return onTap == null
        ? button
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: button,
          );
  }

  void _showAccountSummary(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: const Color(0x990D1220),
      builder: (context) => const _AccountSummaryDialog(),
    );
  }

  void _showStoreDetails(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: const Color(0x990D1220),
      builder: (context) => const _StoreDetailsDialog(),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: const Color(0x990D1220),
      builder: (context) => const _LogoutConfirmationDialog(),
    );
  }

  Widget _buildBottomNavigationBar() {
    const labels = ['Home', 'Pay to\nWholesaler', '', 'Balance', 'Account'];
    const icons = [
      Icons.home_outlined,
      Icons.credit_card_outlined,
      Icons.local_shipping_outlined,
      Icons.wallet_outlined,
      Icons.account_circle_outlined,
    ];
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFDDE5EE))),
      ),
      child: Row(
        children: List.generate(5, (index) {
          if (index == 2) {
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() {
                  _activeService = null;
                  _selectedTab = 2;
                }),
                child: Center(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: AppColors.brandRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_shipping_outlined,
                      color: Colors.white,
                      size: 29,
                    ),
                  ),
                ),
              ),
            );
          }
          final active = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (index == 3) {
                  _showAccountSummary(context);
                  return;
                }
                if (index == 4) {
                  _showStoreDetails(context);
                  return;
                }
                setState(() {
                  _activeService = null;
                  _selectedTab = index;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    color: active
                        ? AppColors.brandRed
                        : const Color(0xFF607696),
                    size: 23,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    labels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: active
                          ? AppColors.brandRed
                          : const Color(0xFF607696),
                      fontSize: 11,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      height: 1.05,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _PayToWholesalerPage extends StatelessWidget {
  const _PayToWholesalerPage();

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
                  onPressed: () {},
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

class _LogoutConfirmationDialog extends StatelessWidget {
  const _LogoutConfirmationDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.logout,
                  color: Color(0xFFD71920),
                  size: 29,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Are you sure you want to log out?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF182033),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 45),
            SizedBox(
              height: 44,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.power_settings_new, size: 17),
                label: const Text('Yes, Log Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC81920),
                  foregroundColor: Colors.white,
                  elevation: 1,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 9),
            SizedBox(
              height: 43,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF0F5F9),
                  foregroundColor: const Color(0xFF34455F),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text('Stay Logged In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreDetailsDialog extends StatelessWidget {
  const _StoreDetailsDialog();

  static const _text = Color(0xFF18233A);
  static const _label = Color(0xFF8A9AB3);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 22, 25, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.info, color: Color(0xFF159B78), size: 18),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Store Details',
                    style: TextStyle(
                      color: _text,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF71839D),
                      size: 19,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _StoreDetailField(
              label: 'TRADING ENTITY',
              value: 'Demo Test Account',
            ),
            const SizedBox(height: 12),
            const _StoreDetailField(label: 'ACCOUNTNUMBER', value: 'PTG999'),
            const SizedBox(height: 12),
            const _StoreDetailField(
              label: 'PHYSICAL ADDRESS',
              value: 'address1, address1, Cape Town, Cape\nTown',
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 37,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111A2F),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoreDetailField extends StatelessWidget {
  const _StoreDetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _StoreDetailsDialog._label,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              color: _StoreDetailsDialog._text,
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountSummaryDialog extends StatelessWidget {
  const _AccountSummaryDialog();

  static const _text = Color(0xFF18233A);
  static const _muted = Color(0xFF8A9AB3);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 23),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFFD7192F),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Account Summary',
                    style: TextStyle(
                      color: _text,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF71839D),
                      size: 19,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFFB71920), Color(0xFFE27600)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'AVAILABLE BALANCE',
                          style: TextStyle(
                            color: Color(0xFFFFF19A),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                        size: 19,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'R 3,039.10',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      height: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Account: PTG999',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 13),
            const _WalletSummaryRow(
              title: 'STANDARD WALLET',
              account: 'PTG999',
              amount: 'R1,039.10',
            ),
            const _WalletSummaryRow(
              title: 'BILLS WALLET',
              account: 'XXPTG9999XX',
              amount: 'R 618.68',
              amountColor: Color(0xFF159B78),
            ),
            const _WalletSummaryRow(
              title: 'CREDIT LIMIT',
              amount: 'R 2,000.00',
            ),
            const _WalletSummaryRow(
              title: 'COMMISSION WALLET',
              amount: 'R 3,988.00',
              amountColor: Color(0xFFE66B00),
            ),
            const _WalletSummaryRow(
              title: 'SWIPE WALLET',
              amount: 'R 1,533.00',
              amountColor: Color(0xFF493CFF),
            ),
            const _WalletSummaryRow(
              title: 'LOYALTY WALLET',
              amount: 'R 5,000.00',
              amountColor: Color(0xFFFF0050),
            ),
            const SizedBox(height: 15),
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF111A2F),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Text(
                    'TOTAL DUE',
                    style: TextStyle(
                      color: Color(0xFFD1D8E3),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'R -494,242.75',
                    style: TextStyle(
                      color: Color(0xFFFFC400),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 41,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF0F5F9),
                  foregroundColor: _text,
                  elevation: 1,
                  shadowColor: const Color(0x22000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletSummaryRow extends StatelessWidget {
  const _WalletSummaryRow({
    required this.title,
    required this.amount,
    this.account,
    this.amountColor = const Color(0xFF18233A),
  });

  final String title;
  final String amount;
  final String? account;
  final Color amountColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: account == null ? 45 : 55,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE6ECF2))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _AccountSummaryDialog._text,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (account != null)
                  Text(
                    account!,
                    style: const TextStyle(
                      color: _AccountSummaryDialog._muted,
                      fontSize: 10,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: amountColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.onTap});

  final _Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFDDE5EE)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A1E3854),
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: service.iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(service.icon, color: service.iconColor, size: 25),
              ),
              const SizedBox(height: 12),
              Text(
                service.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF1E2A40),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                service.subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF8498B6), fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _Service {
  const _Service(
    this.title,
    this.subtitle,
    this.icon,
    this.iconBackground,
    this.iconColor,
  );

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
}

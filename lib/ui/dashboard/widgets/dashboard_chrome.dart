part of '../screens/dashboard_screen.dart';

extension _DashboardChrome on _DashboardScreenState {
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
            final active = _selectedTab == 2;
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _selectBottomTab(2),
                child: Center(
                  child: Transform.translate(
                    offset: active ? const Offset(0, -4) : Offset.zero,
                    child: Container(
                      width: active ? 56 : 52,
                      height: active ? 56 : 52,
                      decoration: const BoxDecoration(
                        color: Color(0x1FC8102E),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40C8102E),
                            blurRadius: 14,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Container(
                          width: active ? 44 : 52,
                          height: active ? 44 : 52,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFFC8102E), Color(0xFFE97800)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
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
                _selectBottomTab(index);
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

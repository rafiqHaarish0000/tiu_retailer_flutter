import 'dart:async';

import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../auth/screens/login_screen.dart';
import '../../modules/account_payments/screens/account_payments_screen.dart';
import '../../modules/commissions_and_invoices/screens/commissions_and_invoices_screen.dart';
import '../../modules/deposit_history/screens/deposit_history_screen.dart';
import '../../modules/financial_transactions/screens/financial_transactions_screen.dart';
import '../../modules/money_transfers/screens/money_transfers_screen.dart';
import '../../modules/my_devices/screens/my_devices_screen.dart';
import '../../modules/my_sales_transactions/screens/my_sales_transactions_screen.dart';
import '../../modules/pay_suppliers/screens/pay_suppliers_screen.dart';
import '../../modules/pos_users/screens/pos_users_screen.dart';
import '../../modules/sales_and_shift_reports/screens/sales_and_shift_reports_screen.dart';
import '../../modules/supplier_orders/screens/supplier_orders_module_screen.dart';
import '../../modules/top_it_up_banking_details/screens/top_it_up_banking_details_screen.dart';
import '../../modules/top_it_up_voucher/screens/top_it_up_voucher_screen.dart';
import '../../modules/transfer_to_stores/screens/transfer_to_stores_screen.dart';
import '../../modules/transfer_to_wallet/screens/transfer_to_wallet_screen.dart';
import '../../modules/view_otp/screens/view_otp_screen.dart';
import '../../modules/website_users/screens/website_users_screen.dart';
import '../../modules/wholesaler_payments/screens/wholesaler_payments_screen.dart';

part '../../bottom_navigation/screens/supplier_orders_screen.dart';
part '../../bottom_navigation/screens/wholesaler_list_screen.dart';
part '../../bottom_navigation/screens/wholesaler_catalog_screen.dart';
part '../../bottom_navigation/widgets/supplier_navigation_widgets.dart';
part '../../bottom_navigation/screens/pay_to_wholesaler_screen.dart';
part '../dialogs/logout_confirmation_dialog.dart';
part '../dialogs/store_details_dialog.dart';
part '../dialogs/account_summary_dialog.dart';
part '../data/dashboard_services.dart';
part '../widgets/dashboard_chrome.dart';
part '../../bottom_navigation/screens/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;
  int _supplierFlow = 0;
  Widget? _activeService;

  void _openService(Widget screen) {
    setState(() {
      _activeService = screen;
      _selectedTab = 0;
    });
  }

  void _openServiceEntry(_Service service) {
    if (service.screen is WholesalerPaymentsScreen) {
      _selectBottomTab(1);
      return;
    }
    final screen = service.screen is AccountPaymentsScreen
        ? AccountPaymentsScreen(onBack: _goHome)
        : service.screen;
    _openService(screen);
  }

  void _goHome() {
    setState(() {
      _activeService = null;
      _selectedTab = 0;
      _supplierFlow = 0;
    });
  }

  void _selectBottomTab(int index) {
    setState(() {
      _activeService = null;
      _selectedTab = index;
      if (index == 2) _supplierFlow = 0;
    });
  }

  static const _services = _dashboardServices;

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
                  ? _activeService!
                  : _selectedTab == 0
                  ? _HomeScreen(
                      services: _services,
                      onServiceTap: _openServiceEntry,
                    )
                  : _selectedTab == 1
                  ? _PayToWholesalerPage(onBack: _goHome)
                  : _selectedTab == 2
                  ? _buildSupplierFlow()
                  : _buildTabComingSoon(_tabTitle(_selectedTab)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSupplierFlow() {
    switch (_supplierFlow) {
      case 1:
        return _WholesalerListPage(
          onBack: () => setState(() => _supplierFlow = 0),
          onPlaceOrder: () => setState(() => _supplierFlow = 2),
        );
      case 2:
        return _WholesalerCatalogPage(
          onBack: () => setState(() => _supplierFlow = 1),
        );
      default:
        return _SupplierOrdersPage(
          onBack: _goHome,
          onPlaceOrder: () => setState(() => _supplierFlow = 1),
        );
    }
  }
}

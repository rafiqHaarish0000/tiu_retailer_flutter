import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class FinancialTransactionsScreen extends StatefulWidget {
  const FinancialTransactionsScreen({this.onBack, super.key});
  final VoidCallback? onBack;
  @override
  State<FinancialTransactionsScreen> createState() =>
      _FinancialTransactionsScreenState();
}

class _FinancialTransactionsScreenState
    extends State<FinancialTransactionsScreen> {
  bool _billWallet = false;
  static const _defaultTransactions = <_TransactionItem>[
    _TransactionItem(
      'Wallet Xfer',
      '2026-11-16 18:12:54',
      '397064',
      '10.00',
      'Wallet Xfer',
    ),
    _TransactionItem(
      'Wallet Xfer',
      '2026-11-16 18:10:33',
      '397062',
      '10.00',
      'Wallet Xfer',
    ),
    _TransactionItem(
      'Wallet Xfer',
      '2026-11-06 21:35:36',
      '397033',
      '12.10',
      'Wallet Xfer',
    ),
    _TransactionItem(
      'Wallet Xfer',
      '2026-11-06 19:27:50',
      '396996',
      '2.00',
      'Wallet Xfer',
    ),
    _TransactionItem(
      'Wallet Xfer',
      '2026-11-06 19:25:17',
      '396994',
      '10.00',
      'Wallet Xfer',
    ),
    _TransactionItem(
      'Wallet Xfer',
      '2026-11-05 14:50:37',
      '396980',
      '15.00',
      'Wallet Xfer',
    ),
    _TransactionItem(
      'Wallet Xfer',
      '2026-11-05 14:42:18',
      '396978',
      '1.00',
      'Wallet Xfer',
    ),
  ];
  static const _billTransactions = <_TransactionItem>[
    _TransactionItem(
      'Wallet Xfer - BILL',
      '2026-11-16 18:12:54',
      '397063',
      '-10.00',
      'Wallet Xfer',
    ),
    _TransactionItem(
      'Wholesaler Payment',
      '2026-11-16 12:10:33',
      '397052',
      '-25.00',
      'Wholesaler Payment',
    ),
    _TransactionItem(
      'Transfer From - BILL',
      '2026-11-10 19:11:57',
      '397048',
      '-21.00',
      'Wholesaler Payment',
    ),
    _TransactionItem(
      'Transfer From - BILL',
      '2026-11-10 18:48:14',
      '397046',
      '-7.00',
      'Wholesaler Payment',
    ),
    _TransactionItem(
      'Transfer From - BILL',
      '2026-11-09 17:22:10',
      '397040',
      '-8.00',
      'Wholesaler Payment',
    ),
  ];
  List<_TransactionItem> get _items =>
      _billWallet ? _billTransactions : _defaultTransactions;

  Future<void> _selectWallet(bool billWallet) async {
    await _showLoading();
    if (mounted) setState(() => _billWallet = billWallet);
  }

  Future<void> _showLoading() async {
    unawaited(
      showGeneralDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierLabel: 'Loading',
        barrierColor: const Color(0x99708091),
        pageBuilder: (dialogContext, animation, secondaryAnimation) =>
            const _LoadingDialog(),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _goBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _openDetails(_TransactionItem item) => showDialog<void>(
    context: context,
    barrierColor: const Color(0x990D1220),
    builder: (_) => _TransactionDialog(item: item, billWallet: _billWallet),
  );

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: const Color(0xFFF5F8FC),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
          child: _TitleBar(onBack: _goBack),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
          child: Row(
            children: [
              Expanded(
                child: _WalletButton(
                  label: 'Default Wallet',
                  selected: !_billWallet,
                  onTap: () => _selectWallet(false),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _WalletButton(
                  label: 'Bill Wallet',
                  selected: _billWallet,
                  onTap: () => _selectWallet(true),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: _TransactionList(
              items: _items,
              billWallet: _billWallet,
              onTap: _openDetails,
            ),
          ),
        ),
      ],
    ),
  );
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.onBack});
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => Container(
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
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          _TitleIcon(
            icon: Icons.arrow_back,
            color: const Color(0xFF28415C),
            background: const Color(0xFFF0F6FA),
            onTap: onBack,
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Financial Transactions',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF11182B),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          _TitleIcon(
            icon: Icons.home_outlined,
            color: AppColors.brandRed,
            background: const Color(0xFFFFF0F2),
            onTap: onBack,
          ),
        ],
      ),
    ),
  );
}

class _TitleIcon extends StatelessWidget {
  const _TitleIcon({
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
  Widget build(BuildContext context) => Material(
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

class _WalletButton extends StatelessWidget {
  const _WalletButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 42,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? AppColors.brandRed : Colors.white,
        foregroundColor: selected ? Colors.white : const Color(0xFF1E2A40),
        elevation: selected ? 4 : 0,
        shadowColor: const Color(0x44C8102E),
        side: selected
            ? BorderSide.none
            : const BorderSide(color: Color(0xFFDDE5EE)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({
    required this.items,
    required this.billWallet,
    required this.onTap,
  });
  final List<_TransactionItem> items;
  final bool billWallet;
  final ValueChanged<_TransactionItem> onTap;
  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(color: const Color(0xFFE1E8F0)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A1E3854),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE6EDF4))),
          ),
          child: Text(
            'My Transactions: ${billWallet ? 'Bill' : 'Default'} Wallet',
            style: const TextStyle(
              color: Color(0xFF1E2A40),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            itemBuilder: (_, index) => _TransactionRow(
              item: items[index],
              onTap: () => onTap(items[index]),
            ),
          ),
        ),
      ],
    ),
  );
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.item, required this.onTap});
  final _TransactionItem item;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Container(
        // The text metrics need a little more room on the 1x mobile layout.
        // Keeping this explicit also prevents Flutter's overflow indicator
        // from appearing between the order number and the row divider.
        height: 82,
        padding: const EdgeInsets.fromLTRB(16, 13, 16, 7),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEAF0F5))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: Color(0xFF11182B),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'R ${item.amount}',
                  style: const TextStyle(
                    color: Color(0xFF11182B),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.date,
                    style: const TextStyle(
                      color: Color(0xFF7287A6),
                      fontSize: 11,
                    ),
                  ),
                ),
                Text(
                  'Ref: ${item.reference}',
                  style: const TextStyle(
                    color: Color(0xFF7287A6),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              'Order No: ${item.order}',
              style: const TextStyle(color: Color(0xFF8EA1BC), fontSize: 11),
            ),
          ],
        ),
      ),
    ),
  );
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();
  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 126,
      height: 102,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 38,
            height: 38,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.brandRed),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Loading...',
            style: TextStyle(
              color: Color(0xFF1E2A40),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}

class _TransactionDialog extends StatelessWidget {
  const _TransactionDialog({required this.item, required this.billWallet});
  final _TransactionItem item;
  final bool billWallet;
  @override
  Widget build(BuildContext context) {
    final text =
        'Financial Transactions\n----------------------------\nStore: Demo Test Account\nAccount: XXPTG999XX\nWallet: ${billWallet ? 'Bill Wallet' : 'Default Wallet'}\nTransaction #: ${item.reference}\nType: ${billWallet ? 'Wallet Xfer – BILL' : 'Wallet Xfer'}\nDate: ${item.date}\nReference: 0243161126QEP0356\nOrder No: ${item.order}\nAmount: R ${item.amount}';
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 353),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Financial Transaction',
                      style: TextStyle(
                        color: Color(0xFF11182B),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F6FA),
                      foregroundColor: const Color(0xFF1E2A40),
                      padding: EdgeInsets.zero,
                      fixedSize: const Size(32, 32),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF1E2A40),
                    fontFamily: 'monospace',
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionItem {
  const _TransactionItem(
    this.title,
    this.date,
    this.reference,
    this.amount,
    this.order,
  );
  final String title, date, reference, amount, order;
}

import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class DepositHistoryScreen extends StatelessWidget {
  const DepositHistoryScreen({this.onBack, super.key});
  final VoidCallback? onBack;

  void _back(BuildContext context) {
    if (onBack != null) {
      onBack!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: const Color(0xFFF2F6FA),
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      child: Column(
        children: [
          _TitleBar(onBack: () => _back(context)),
          const SizedBox(height: 16),
          const _DepositList(),
          const SizedBox(height: 16),
          _BackButton(onTap: () => _back(context)),
          const SizedBox(height: 30),
          const _ContactFooter(),
        ],
      ),
    ),
  );
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.onBack});
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 56,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(color: const Color(0xFFE2E9F0)),
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
          'Deposit History',
          style: TextStyle(
            color: Color(0xFF11182B),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Positioned(
          left: 8,
          child: _IconBox(
            icon: Icons.arrow_back,
            color: const Color(0xFF28415C),
            background: const Color(0xFFF0F6FA),
            onTap: onBack,
          ),
        ),
        Positioned(
          right: 8,
          child: _IconBox(
            icon: Icons.home_outlined,
            color: AppColors.brandRed,
            background: const Color(0xFFFFF0F2),
            onTap: onBack,
          ),
        ),
      ],
    ),
  );
}

class _IconBox extends StatelessWidget {
  const _IconBox({
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

class _DepositList extends StatelessWidget {
  const _DepositList();
  static const deposits = [
    _Deposit(
      'R -23.00',
      '2026-11-10 19:13:54',
      '0143101126EqQCKd14xG',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -22.00',
      '2026-11-10 19:13:15',
      '0143101126XvsdLS1nS6',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -21.00',
      '2026-11-10 19:11:57',
      '0141101126MWNXFEHFMr',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -7.00',
      '2026-11-10 18:48:14',
      '0118101126AkAlq8r1ID',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -8.00',
      '2026-11-10 18:41:13',
      '0111101126ZI4OvaAbZ',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -9.00',
      '2026-11-10 18:33:16',
      '0103101126YBltbD9pUr',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -12.00',
      '2026-11-10 18:27:22',
      '1257101126qcvigGqL9H',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -11.00',
      '2026-11-10 18:23:45',
      '1254101126ImWZ5IiZKi',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -10.00',
      '2026-11-10 18:13:52',
      '1244110126nDlq3e2gT',
      'Store Xfer to MNN897',
      false,
    ),
    _Deposit(
      'R -2.00',
      '2026-11-06 21:36:16',
      '040601126QDWZOOO',
      'Store Xfer to TIU221',
      false,
    ),
    _Deposit(
      'R 12.10',
      '2026-11-06 21:35:36',
      '0405061126WRZP0356',
      'Wallet Xfer',
      true,
    ),
    _Deposit(
      'R -12.10',
      '2026-11-06 21:35:36',
      '0405061126WRZP0356',
      'Wallet Xfer',
      false,
    ),
    _Deposit(
      'R -9.00',
      '2026-11-06 15:25:12',
      'OVer202611051048',
      'PAYSHAP',
      false,
    ),
    _Deposit(
      'R 1.00',
      '2026-11-05 14:54:00',
      '0924051126SnymO000',
      'Store Xfer From PTG999',
      false,
    ),
    _Deposit(
      'R -1.00',
      '2026-11-05 14:54:00',
      '0924051126SnymO000',
      'Store Xfer to PTG999',
      false,
    ),
    _Deposit(
      'R 1.00',
      '2026-11-05 14:50:37',
      '0920051126NGSL0356',
      'Wallet Xfer',
      true,
    ),
  ];
  @override
  Widget build(BuildContext context) => Container(
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(
      color: Color(0xFFEFF4F8),
      borderRadius: BorderRadius.all(Radius.circular(16)),
      border: Border.fromBorderSide(BorderSide(color: Color(0xFFDDE5ED))),
    ),
    child: Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(15, 11, 15, 11),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Color(0xFF60718C), fontSize: 14),
                    children: [
                      TextSpan(text: 'Last 25 Deposits for: '),
                      TextSpan(
                        text: 'PTG999',
                        style: TextStyle(
                          color: AppColors.brandRed,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '25',
                  style: TextStyle(
                    color: AppColors.brandRed,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFDDE5ED)),
        ...deposits.map((deposit) => _DepositCard(deposit: deposit)),
        const SizedBox(height: 12),
      ],
    ),
  );
}

class _Deposit {
  const _Deposit(
    this.amount,
    this.date,
    this.reference,
    this.order,
    this.standardWallet,
  );
  final String amount;
  final String date;
  final String reference;
  final String order;
  final bool standardWallet;
}

class _DepositCard extends StatelessWidget {
  const _DepositCard({required this.deposit});
  final _Deposit deposit;
  @override
  Widget build(BuildContext context) {
    final accent = deposit.standardWallet
        ? const Color(0xFF2E66EF)
        : const Color(0xFF1D9C6E);
    return Container(
      margin: const EdgeInsets.fromLTRB(11, 12, 11, 0),
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDE5ED)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x081E2A40),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5, color: accent),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 11),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            deposit.amount,
                            style: const TextStyle(
                              color: Color(0xFF152038),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: deposit.standardWallet
                                ? const Color(0xFFDCE9FF)
                                : const Color(0xFFD9F7E7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            deposit.standardWallet
                                ? 'Standard wallet'
                                : 'Cash wallet',
                            style: TextStyle(
                              color: deposit.standardWallet
                                  ? const Color(0xFF2355C6)
                                  : const Color(0xFF167044),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        deposit.date,
                        style: const TextStyle(
                          color: Color(0xFF60718C),
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        _InfoBox(label: 'REFERENCE', value: deposit.reference),
                        const SizedBox(width: 6),
                        _InfoBox(label: 'ORDER NUMBER', value: deposit.order),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      height: 64,
      padding: const EdgeInsets.fromLTRB(9, 7, 7, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE4EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF60718C), fontSize: 9),
          ),
          const SizedBox(height: 3),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF17233B),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 40,
    child: FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.brandRed,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 21),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
      child: const Text(
        'Back',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class _ContactFooter extends StatelessWidget {
  const _ContactFooter();
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Divider(color: Color(0xFFDDE5ED)),
      const SizedBox(height: 10),
      const Text(
        '☎  0860 111 723   |   ◉  Whatsapp: 064 121 9970',
        style: TextStyle(color: Color(0xFF58708F), fontSize: 11),
      ),
      const SizedBox(height: 8),
      const Text(
        'info@topitup.co.za   |   www.topitup.co.za',
        style: TextStyle(color: Color(0xFF58708F), fontSize: 11),
      ),
    ],
  );
}

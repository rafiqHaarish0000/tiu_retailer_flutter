import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class TopItUpBankingDetailsScreen extends StatefulWidget {
  const TopItUpBankingDetailsScreen({this.onBack, super.key});
  final VoidCallback? onBack;

  @override
  State<TopItUpBankingDetailsScreen> createState() =>
      _TopItUpBankingDetailsScreenState();
}

class _TopItUpBankingDetailsScreenState
    extends State<TopItUpBankingDetailsScreen> {
  String? _expandedBank;

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
      color: const Color(0xFFF2F6FA),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          children: [
            _TitleBar(onBack: _back),
            const SizedBox(height: 16),
            const _AccountCard(),
            const SizedBox(height: 16),
            _BankSection(
              expandedBank: _expandedBank,
              onBankTap: (bank) => setState(() {
                _expandedBank = _expandedBank == bank ? null : bank;
              }),
            ),
            const SizedBox(height: 16),
            const _PayPointSection(),
            const SizedBox(height: 16),
            _BackButton(onTap: _back),
          ],
        ),
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Banking Details',
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

class _AccountCard extends StatelessWidget {
  const _AccountCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: _cardDecoration,
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Demo Test Account',
                  style: TextStyle(
                    color: Color(0xFF11182B),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'Mobile App passcode',
                style: TextStyle(color: Color(0xFF607696), fontSize: 11),
              ),
            ],
          ),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Account PTG999',
                  style: TextStyle(color: Color(0xFF607696), fontSize: 12),
                ),
              ),
              Text(
                '494829',
                style: TextStyle(
                  color: Color(0xFF254CFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBED),
              border: Border.all(color: const Color(0xFFFFD45B)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Please use your Account Number PTG999 when\ndepositing money to avoid delays.',
              style: TextStyle(
                color: Color(0xFF4F5864),
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              _HeaderCell(
                title: 'Banking\nAccount #',
                color: const Color(0xFFFFF6C9),
              ),
              const SizedBox(width: 6),
              _HeaderCell(
                title: 'PayPoint\nAccount #',
                color: const Color(0xFFFFE8D5),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const _AccountRow(
            label: 'Standard Wallet',
            account: 'PTG999',
            number: '11790 067894',
          ),
          const SizedBox(height: 6),
          const _AccountRow(
            label: 'Bill Payments\nWallet',
            account: 'XXPTG999XX',
            number: '11790 749876',
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 99,
    height: 47,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF7D351E),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

class _AccountRow extends StatelessWidget {
  const _AccountRow({
    required this.label,
    required this.account,
    required this.number,
  });
  final String label;
  final String account;
  final String number;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFDFF2FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF07547E), fontSize: 12),
          ),
        ),
      ),
      const SizedBox(width: 6),
      _ValueCell(text: account),
      const SizedBox(width: 6),
      _ValueCell(text: number),
    ],
  );
}

class _ValueCell extends StatelessWidget {
  const _ValueCell({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 99,
    height: 36,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDCE5EE)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1E2A40),
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

const _cardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(16)),
  border: Border.fromBorderSide(BorderSide(color: Color(0xFFDDE5ED))),
  boxShadow: [
    BoxShadow(color: Color(0x0A1E2A40), blurRadius: 12, offset: Offset(0, 5)),
  ],
);

class _BankSection extends StatelessWidget {
  const _BankSection({required this.expandedBank, required this.onBankTap});
  final String? expandedBank;
  final ValueChanged<String> onBankTap;
  @override
  Widget build(BuildContext context) => Container(
    decoration: _cardDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _BlueSectionTitle(title: 'Banks'),
        ..._bankData.map(
          (bank) => _BankCard(
            data: bank,
            expanded: expandedBank == bank.name,
            onTap: () => onBankTap(bank.name),
          ),
        ),
      ],
    ),
  );
}

class _BlueSectionTitle extends StatelessWidget {
  const _BlueSectionTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Container(
    height: 44,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    alignment: Alignment.centerLeft,
    decoration: const BoxDecoration(
      color: Color(0xFF218CCA),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _BankData {
  const _BankData(
    this.name,
    this.shortName,
    this.account,
    this.method,
    this.logoColor,
  );
  final String name;
  final String shortName;
  final String account;
  final String method;
  final Color logoColor;
}

const _bankData = [
  _BankData(
    'ABSA',
    'ABSA',
    '407 961 8709',
    'Cash deposit, Atm or EFT',
    Color(0xFFC8102E),
  ),
  _BankData('FNB', 'FNB', '624 033 09356', 'EFT Only', Color(0xFF16A5B0)),
  _BankData(
    'Nedbank',
    'NEDBANK',
    '133 403 3870',
    'Cash deposit, Atm or EFT',
    Color(0xFF17604C),
  ),
  _BankData(
    'Standard Bank',
    'Standard Bank',
    '061738298',
    'EFT Only',
    Color(0xFF0D347C),
  ),
];

class _BankCard extends StatelessWidget {
  const _BankCard({
    required this.data,
    required this.expanded,
    required this.onTap,
  });
  final _BankData data;
  final bool expanded;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFDDE5ED)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x081E2A40),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            _BankSummary(data: data, onTap: onTap),
            if (expanded) _BankDetails(data: data),
          ],
        ),
      ),
    );
  }
}

class _BankSummary extends StatelessWidget {
  const _BankSummary({required this.data, required this.onTap});
  final _BankData data;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            data.shortName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: data.logoColor,
              fontSize: data.name == 'ABSA' ? 22 : 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${data.method} ›',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF064CFF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _BankDetails extends StatelessWidget {
  const _BankDetails({required this.data});
  final _BankData data;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      _detail('Bank', data.name),
      _detail('Account Name', 'Top it Up'),
      _detail('Account Type', 'Current'),
      _detail('Account #', data.account),
      _detail('Branch Name', 'Vangate Mall'),
      _detail('Method', data.method, red: true),
      const SizedBox(height: 7),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0F0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          data.name == 'ABSA' || data.name == 'Nedbank'
              ? 'Note: Deposits Less than R2,000 will incur a R6 fee.'
              : 'Note: Cash deposit fees at 1%.',
          style: const TextStyle(color: Color(0xFFA82020), fontSize: 11),
        ),
      ),
      const SizedBox(height: 8),
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Reference: Standard wallet PTG999 · Bill Payments\nwallet XXPTG999XX',
          style: const TextStyle(
            color: Color(0xFF60718C),
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ),
    ],
  );
  Widget _detail(String label, String value, {bool red = false}) => Container(
    height: 28,
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFE9EEF3))),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF70829D), fontSize: 12),
          ),
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyle(
                color: red ? AppColors.brandRed : const Color(0xFF18233A),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _PayPointSection extends StatelessWidget {
  const _PayPointSection();
  static const _merchants = [
    ('Checkers', 'R6.70'),
    ('SHOPRITE', 'R6.70'),
    ('Shoprite Save', 'R6.70'),
    ('Pick n Pay', 'R5.50'),
    ('Boxer', 'R5.50'),
    ('Jumbo', 'R6.70'),
    ('Cambridge food', 'R6.70'),
    ('Build it', 'R6.70'),
    ('Game', 'R6.70'),
    ('makro', 'R6.70'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _BlueSectionTitle(title: 'PayPoint'),
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Text(
              'Min deposit R500 · Max deposit R15,000 · Debit card 1.5% · Credit card 2.5%\nPay with PayPoint Account # 11790 067894 (Standard)\nor 11790 749876 (Bill Payments)',
              style: TextStyle(
                color: Color(0xFF52627B),
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _merchants.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 70,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: const Color(0xFFDDE5ED)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _merchants[index].$1,
                        style: const TextStyle(
                          color: Color(0xFF202B3C),
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Fee ${_merchants[index].$2}',
                        style: const TextStyle(
                          color: Color(0xFF60718C),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 48,
    child: FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.brandRed,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
      child: const Text(
        'Back',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

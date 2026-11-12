import 'package:flutter/material.dart';

class AccountPaymentsScreen extends StatefulWidget {
  const AccountPaymentsScreen({this.onBack, super.key});

  final VoidCallback? onBack;

  @override
  State<AccountPaymentsScreen> createState() => _AccountPaymentsScreenState();
}

class _AccountPaymentsScreenState extends State<AccountPaymentsScreen> {
  final _amountController = TextEditingController();
  final _quickpassController = TextEditingController();
  int _selectedWallet = 0;

  static const ink = Color(0xFF18233A);
  static const muted = Color(0xFF8A9AB3);
  static const blue = Color(0xFF2D64F1);

  @override
  void dispose() {
    _amountController.dispose();
    _quickpassController.dispose();
    super.dispose();
  }

  void _transfer() {
    FocusScope.of(context).unfocus();
    final message = _amountController.text.trim().isEmpty
        ? 'Please enter a transfer amount.'
        : _quickpassController.text.trim().isEmpty
        ? 'Please enter your Quickpass Code.'
        : 'Transfer details are ready to submit.';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF4F7FA),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
        child: Column(
          children: [
            const _WalletBalancesCard(),
            const SizedBox(height: 26),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 18, 15, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x101E3854),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 57,
                      height: 57,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF1FF),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: const Icon(
                        Icons.swap_horiz,
                        color: blue,
                        size: 31,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Transfer From Wallet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Select the wallet you want to transfer funds from',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: muted, fontSize: 13),
                  ),
                  const SizedBox(height: 23),
                  const _FieldLabel('Choose Source Wallet'),
                  const SizedBox(height: 12),
                  _WalletChoice(
                    selected: _selectedWallet == 0,
                    icon: Icons.bolt,
                    iconColor: const Color(0xFF0786A8),
                    iconBackground: const Color(0xFFE2F8FC),
                    title: 'Bill Wallet',
                    subtitle: 'Fast fund transfer',
                    onTap: () => setState(() => _selectedWallet = 0),
                  ),
                  const SizedBox(height: 16),
                  _WalletChoice(
                    selected: _selectedWallet == 1,
                    icon: Icons.query_stats,
                    iconColor: const Color(0xFF7C3AED),
                    iconBackground: const Color(0xFFF2E9FF),
                    title: 'Commission Wallet',
                    subtitle: 'Transfer your earned commission',
                    onTap: () => setState(() => _selectedWallet = 1),
                  ),
                  const SizedBox(height: 18),
                  const _FieldLabel('Transfer Amount'),
                  const SizedBox(height: 10),
                  _TransferField(
                    controller: _amountController,
                    prefix: const Text(
                      'R',
                      style: TextStyle(
                        color: Color(0xFF405064),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    hint: 'Enter transfer amount',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const _HelpText(
                    icon: Icons.info,
                    text: 'Enter the amount you wish to transfer.',
                  ),
                  const SizedBox(height: 12),
                  const _FieldLabel('Quickpass Code'),
                  const SizedBox(height: 10),
                  _TransferField(
                    controller: _quickpassController,
                    prefix: const Icon(
                      Icons.lock,
                      color: Color(0xFF60758C),
                      size: 21,
                    ),
                    hint: 'Enter your Quickpass Code',
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                  const SizedBox(height: 7),
                  const _HelpText(
                    icon: Icons.lock,
                    text: 'Your Quickpass code keeps your transfer secure.',
                  ),
                  const SizedBox(height: 26),
                  const Divider(color: Color(0xFFE5EBF1), height: 1),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _ActionButton(
                          label: 'Back',
                          icon: Icons.arrow_back,
                          background: const Color(0xFFEDF1F6),
                          foreground: const Color(0xFF45566D),
                          onPressed: widget.onBack ?? () {},
                        ),
                      ),
                      const SizedBox(width: 11),
                      Expanded(
                        child: _ActionButton(
                          label: 'Transfer\nFunds',
                          icon: Icons.sync_alt,
                          background: blue,
                          foreground: Colors.white,
                          onPressed: _transfer,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletBalancesCard extends StatelessWidget {
  const _WalletBalancesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Color(0x101E3854),
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 17, 16, 15),
            child: Row(
              children: [
                _BankIcon(),
                SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transfer to Bank Account',
                        style: TextStyle(
                          color: _AccountPaymentsScreenState.ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Your available wallet balances',
                        style: TextStyle(
                          color: _AccountPaymentsScreenState.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 39,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            color: const Color(0xFFF7F9FB),
            child: const Row(
              children: [
                Expanded(flex: 4, child: _TableHeading('WALLET')),
                Expanded(flex: 4, child: _TableHeading('ACCOUNT NUMBER')),
                Expanded(flex: 3, child: _TableHeading('FUNDS TO TRANSFER')),
              ],
            ),
          ),
          const _WalletBalanceRow(
            icon: Icons.account_balance_wallet_outlined,
            iconColor: Color(0xFF3767F2),
            iconBackground: Color(0xFFEAF0FF),
            wallet: 'Standard\nWallet',
            account: 'PTG999',
            amount: 'R 0.00',
          ),
          const _WalletBalanceRow(
            icon: Icons.bolt,
            iconColor: Color(0xFF0786A8),
            iconBackground: Color(0xFFE2F8FC),
            wallet: 'Bill Wallet',
            account: 'XX PTG999XX',
            amount: 'R 618.68',
          ),
          const _WalletBalanceRow(
            icon: Icons.query_stats,
            iconColor: Color(0xFF7C3AED),
            iconBackground: Color(0xFFF2E9FF),
            wallet: 'Commission\nWallet',
            account: 'PTG999',
            amount: 'R 3,988.00',
          ),
          const _WalletBalanceRow(
            icon: Icons.credit_card,
            iconColor: Color(0xFF159B78),
            iconBackground: Color(0xFFE5F8F1),
            wallet: 'Swipe\nWallet',
            account: 'PTG999',
            amount: 'R 1,533.00',
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(21, 15, 21, 14),
            color: const Color(0xFFF8FAFC),
            child: const Text(
              'Your wallet balances are displayed securely.',
              style: TextStyle(color: Color(0xFF8A9AB3), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _BankIcon extends StatelessWidget {
  const _BankIcon();
  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 48,
    decoration: const BoxDecoration(
      color: Color(0xFFEAF1FF),
      shape: BoxShape.circle,
    ),
    child: const Icon(
      Icons.account_balance,
      color: _AccountPaymentsScreenState.blue,
      size: 27,
    ),
  );
}

class _TableHeading extends StatelessWidget {
  const _TableHeading(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.clip,
    style: const TextStyle(
      color: Color(0xFF7F8DA3),
      fontSize: 9,
      letterSpacing: .45,
      fontWeight: FontWeight.w700,
    ),
  );
}

class _WalletBalanceRow extends StatelessWidget {
  const _WalletBalanceRow({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.wallet,
    required this.account,
    required this.amount,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String wallet;
  final String account;
  final String amount;

  @override
  Widget build(BuildContext context) => Container(
    height: 57,
    padding: const EdgeInsets.symmetric(horizontal: 11),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFE3E9EF))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  wallet,
                  style: const TextStyle(
                    color: _AccountPaymentsScreenState.ink,
                    fontSize: 11,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            account,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF52677D), fontSize: 10),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8FAF2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                amount,
                maxLines: 1,
                style: const TextStyle(
                  color: Color(0xFF158A62),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: _AccountPaymentsScreenState.ink,
      fontSize: 13,
      fontWeight: FontWeight.w800,
    ),
  );
}

class _WalletChoice extends StatelessWidget {
  const _WalletChoice({
    required this.selected,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final bool selected;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: selected ? const Color(0xFFF4F7FF) : Colors.white,
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 69,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selected
                ? _AccountPaymentsScreenState.blue
                : const Color(0xFFDCE4EC),
            width: selected ? 1.2 : 1,
          ),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x1A2D64F1),
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: iconColor, size: 23),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: _AccountPaymentsScreenState.ink,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: _AccountPaymentsScreenState.muted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check, color: _AccountPaymentsScreenState.blue),
          ],
        ),
      ),
    ),
  );
}

class _TransferField extends StatelessWidget {
  const _TransferField({
    required this.controller,
    required this.prefix,
    required this.hint,
    required this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final Widget prefix;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) => Container(
    height: 56,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: const Color(0xFFDCE4EC)),
    ),
    child: Row(
      children: [
        SizedBox(width: 54, child: Center(child: prefix)),
        Container(width: 1, height: 31, color: const Color(0xFFE2E8EF)),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: const TextStyle(color: _AccountPaymentsScreenState.ink),
            decoration: InputDecoration(
              filled: false,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFFA5B2C5),
                fontSize: 13,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 18),
            ),
          ),
        ),
      ],
    ),
  );
}

class _HelpText extends StatelessWidget {
  const _HelpText({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: _AccountPaymentsScreenState.blue, size: 10),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(color: Color(0xFF8A9AB3), fontSize: 10),
        ),
      ),
    ],
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        elevation: 0,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15),
          const SizedBox(width: 9),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    ),
  );
}

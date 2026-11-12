part of '../screens/dashboard_screen.dart';

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

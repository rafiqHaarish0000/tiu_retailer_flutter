import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
import '../theme/app_colors.dart';

String formatRand(double value) {
  final negative = value < 0;
  final fixed = value.abs().toStringAsFixed(2);
  final parts = fixed.split('.');
  final whole = parts[0].replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  return '${negative ? '-' : ''}R$whole.${parts[1]}';
}

class WalletInfo {
  const WalletInfo(this.name, this.funds);
 
  final String name;
  final double funds;
}

class WalletTransferData {
  const WalletTransferData({
    required this.availableBalance,
    required this.wallets,
  });
 
  final double availableBalance;
  final List<WalletInfo> wallets;
}


class WalletTransferResult {
  const WalletTransferResult({
    required this.success,
    this.message,
    this.wallets,
  });
 
  final bool success;
  final String? message;
 
  /// Updated wallet balances after a successful transfer.
  final List<WalletInfo>? wallets;
}

 
abstract class WalletTransferRepository {
  /// Loads the available balance and the wallet balances.
  Future<WalletTransferData> load();
 
  /// Moves [amount] from wallet [from] to wallet [to].
  Future<WalletTransferResult> transfer({
    required WalletInfo from,
    required WalletInfo to,
    required double amount,
  });
}


class MockWalletTransferRepository implements WalletTransferRepository {
  final double _availableBalance = 1010.00;
 
  List<WalletInfo> _wallets = const [
    WalletInfo('Standard Wallet', 500.00),
    WalletInfo('Bill Wallet', 789.78),
    WalletInfo('Commission Wallet', 3990.00),
    WalletInfo('Swipe Wallet', 1535.00),
  ];
 
  @override
  Future<WalletTransferData> load() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return WalletTransferData(
      availableBalance: _availableBalance,
      wallets: _wallets,
    );
  }
 
  @override
  Future<WalletTransferResult> transfer({
    required WalletInfo from,
    required WalletInfo to,
    required double amount,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
 
    final source = _wallets.firstWhere((w) => w.name == from.name);
    if (amount > source.funds) {
      return WalletTransferResult(
        success: false,
        message: 'Insufficient funds in ${from.name}.',
      );
    }
 
    _wallets = _wallets.map((w) {
      if (w.name == from.name) return WalletInfo(w.name, w.funds - amount);
      if (w.name == to.name) return WalletInfo(w.name, w.funds + amount);
      return w;
    }).toList();
 
    return WalletTransferResult(success: true, wallets: _wallets);
  }
}


class TransferToWalletPage extends StatefulWidget {
  TransferToWalletPage({
    super.key,
    required this.onBack,
    WalletTransferRepository? repository,
  }) : repository = repository ?? MockWalletTransferRepository();
 
  final VoidCallback onBack;
  final WalletTransferRepository repository;
 
  @override
  State<TransferToWalletPage> createState() => _TransferToWalletPageState();
}
 
class _TransferToWalletPageState extends State<TransferToWalletPage> {
  final _randController = TextEditingController();
  final _centsController = TextEditingController();
 
  double _availableBalance = 0;
  List<WalletInfo> _wallets = const [];
  bool _loading = true;
  String? _loadError;
 
  int? _from;
  int? _to;
  bool _submitting = false;
 
  @override
  void initState() {
    super.initState();
    _load();
  }
 
  @override
  void dispose() {
    _randController.dispose();
    _centsController.dispose();
    super.dispose();
  }
 
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final data = await widget.repository.load();
      if (!mounted) return;
      setState(() {
        _availableBalance = data.availableBalance;
        _wallets = data.wallets;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadError = 'Could not load wallet details.';
      });
    }
  }
 
  double get _amount {
    final rand = int.tryParse(_randController.text) ?? 0;
    // "5" in the cents box is treated as 50 cents
    final cents = int.tryParse(_centsController.text.padRight(2, '0')) ?? 0;
    return rand + cents / 100;
  }
 
  void _selectFrom(int index) => setState(() {
    _from = index;
    if (_to == index) _to = null;
  });
 
  void _selectTo(int index) => setState(() {
    _to = index;
    if (_from == index) _from = null;
  });
 
  void _snack(String message, {bool error = true}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: error
              ? const Color(0xFFC81920)
              : const Color(0xFF168A63),
        ),
      );
  }
 
  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (_from == null || _to == null) {
      _snack('Select both the source and destination wallet.');
      return;
    }
    final amount = _amount;
    if (amount <= 0) {
      _snack('Enter an amount greater than R0.00.');
      return;
    }
    final from = _wallets[_from!];
    final to = _wallets[_to!];
    if (amount > from.funds) {
      _snack('Insufficient funds in ${from.name}.');
      return;
    }
 
    setState(() => _submitting = true);
 
    WalletTransferResult result;
    try {
      result = await widget.repository.transfer(
        from: from,
        to: to,
        amount: amount,
      );
    } catch (_) {
      result = const WalletTransferResult(
        success: false,
        message: 'Transfer failed. Please try again.',
      );
    }
    if (!mounted) return;
    setState(() => _submitting = false);
 
    if (result.success) {
      setState(() {
        if (result.wallets != null) _wallets = result.wallets!;
      });
      _randController.clear();
      _centsController.clear();
      _snack(
        '${formatRand(amount)} moved from ${from.name} to ${to.name}.',
        error: false,
      );
    } else {
      _snack(result.message ?? 'Transfer failed. Please try again.');
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitleBar(),
          const SizedBox(height: 12),
          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 60),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_loadError != null)
            _buildError()
          else ...[
            _buildAvailableBalance(),
            const SizedBox(height: 12),
            _buildWalletTable(),
            const SizedBox(height: 12),
            _buildTransferCard(),
          ],
        ],
      ),
    );
  }
 
  BoxDecoration get _cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: const Color(0xFFDDE5EE)),
    boxShadow: const [
      BoxShadow(color: Color(0x101E3854), blurRadius: 8, offset: Offset(0, 3)),
    ],
  );
 
  /// Card with the green accent bar on the left, as in the design.
  Widget _greenAccentCard({required Widget child}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: _cardDecoration,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: const Color(0xFF168A63)),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
 
  Widget _buildError() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration,
      child: Column(
        children: [
          Text(
            _loadError!,
            style: const TextStyle(color: Color(0xFF52677D), fontSize: 13),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _load,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandRed,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
 
  Widget _buildTitleBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: _cardDecoration,
      child: Row(
        children: [
          _iconBox(Icons.arrow_back, const Color(0xFF20334F), widget.onBack),
          const Expanded(
            child: Text(
              'Transfer to Wallet',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF18233A),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          _iconBox(
            Icons.home_outlined,
            AppColors.brandRed,
            widget.onBack,
            background: const Color(0xFFFFEFF0),
          ),
        ],
      ),
    );
  }
 
  Widget _iconBox(
    IconData icon,
    Color color,
    VoidCallback onTap, {
    Color background = const Color(0xFFF2F6FA),
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
 
  Widget _buildAvailableBalance() {
    return _greenAccentCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'AVAILABLE BALANCE',
                style: TextStyle(
                  color: Color(0xFF52677D),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              formatRand(_availableBalance),
              style: const TextStyle(
                color: Color(0xFF168A63),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget _buildWalletTable() {
    const headStyle = TextStyle(
      color: Color(0xFF8498B6),
      fontSize: 9,
      fontWeight: FontWeight.w700,
      letterSpacing: .3,
    );
    return _greenAccentCard(
      child: Column(
        children: [
          Container(
            color: const Color(0xFFF6F8FA),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('WALLET', style: headStyle),
                Text('FUNDS TO TRANSFER', style: headStyle),
              ],
            ),
          ),
          for (final wallet in _wallets)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE6ECF2))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    wallet.name,
                    style: const TextStyle(
                      color: Color(0xFF18233A),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formatRand(wallet.funds),
                    style: const TextStyle(
                      color: Color(0xFF168A63),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
 
  Widget _buildTransferCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: _cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _walletColumn(
                  label: 'TRANSFER FROM',
                  selected: _from,
                  onSelect: _selectFrom,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _walletColumn(
                  label: 'TRANSFER TO',
                  selected: _to,
                  onSelect: _selectTo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'TRANSFER AMOUNT',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF52677D),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: .4,
            ),
          ),
          const SizedBox(height: 8),
          _buildAmountInput(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  label: 'Back',
                  background: const Color(0xFFE0E7F0),
                  foreground: const Color(0xFF20334F),
                  onPressed: _submitting ? null : widget.onBack,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _actionButton(
                  label: 'Transfer Funds',
                  background: const Color(0xFF168A4A),
                  foreground: Colors.white,
                  loading: _submitting,
                  onPressed: _submitting ? null : _submit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
 
  Widget _walletColumn({
    required String label,
    required int? selected,
    required ValueChanged<int> onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF52677D),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < _wallets.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _walletChip(
              name: _wallets[i].name,
              selected: selected == i,
              onTap: () => onSelect(i),
            ),
          ),
      ],
    );
  }
 
  Widget _walletChip({
    required String name,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFF3F3) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.brandRed : const Color(0xFFDDE5EE),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: const Color(0xFF18233A),
            fontSize: 11,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
 
  Widget _buildAmountInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'R',
          style: TextStyle(
            color: Color(0xFF18233A),
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(width: 10),
        _amountField(
          controller: _randController,
          hint: '0',
          width: 100,
          maxLength: 7,
          align: TextAlign.right,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        _amountField(
          controller: _centsController,
          hint: '00',
          width: 60,
          maxLength: 2,
          align: TextAlign.center,
        ),
      ],
    );
  }
 
  Widget _amountField({
    required TextEditingController controller,
    required String hint,
    required double width,
    required int maxLength,
    required TextAlign align,
  }) {
    return SizedBox(
      width: width,
      height: 42,
      child: TextField(
        controller: controller,
        textAlign: align,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: maxLength,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFB0BCCB)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFDDE5EE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF168A4A), width: 1.5),
          ),
        ),
      ),
    );
  }
 
  Widget _actionButton({
    required String label,
    required Color background,
    required Color foreground,
    required VoidCallback? onPressed,
    bool loading = false,
  }) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background.withValues(alpha: .6),
          disabledForegroundColor: foreground.withValues(alpha: .8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: loading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: foreground,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
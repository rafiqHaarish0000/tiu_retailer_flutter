import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class SalesAndShiftReportsScreen extends StatefulWidget {
  const SalesAndShiftReportsScreen({this.onBack, super.key});
  final VoidCallback? onBack;
  @override
  State<SalesAndShiftReportsScreen> createState() =>
      _SalesAndShiftReportsScreenState();
}

class _SalesAndShiftReportsScreenState
    extends State<SalesAndShiftReportsScreen> {
  bool _showZReports = false;
  String? _selectedZReport;
  final ScrollController _zReportsController = ScrollController();
  DateTime _selectedDate = DateTime.now();
  final LayerLink _dateLink = LayerLink();
  OverlayEntry? _calendarEntry;

  Future<void> _selectTab(bool showZReports) async {
    await _showLoading();
    if (mounted) setState(() => _showZReports = showZReports);
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
    if (mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  void _showDatePicker() {
    if (_calendarEntry != null) {
      _closeDatePicker();
      return;
    }
    _calendarEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeDatePicker,
            ),
          ),
          CompositedTransformFollower(
            link: _dateLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: const Offset(0, 7),
            child: _SalesCalendar(
              selectedDate: _selectedDate,
              onDismiss: _closeDatePicker,
              onDateSelected: (date) {
                setState(() => _selectedDate = date);
                _closeDatePicker();
              },
            ),
          ),
        ],
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_calendarEntry!);
  }

  void _closeDatePicker() {
    _calendarEntry?.remove();
    _calendarEntry = null;
  }

  void _goBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _selectZHistory(String number) {
    setState(() => _selectedZReport = number);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_zReportsController.hasClients) {
        _zReportsController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _closeDatePicker();
    _zReportsController.dispose();
    super.dispose();
  }

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
                child: _TabButton(
                  label: 'Customer Sales',
                  selected: !_showZReports,
                  onTap: () => _selectTab(false),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TabButton(
                  label: 'Customer Z Reports',
                  selected: _showZReports,
                  onTap: () => _selectTab(true),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _showZReports ? _buildZReports() : _buildCustomerSales(),
        ),
      ],
    ),
  );

  Widget _buildCustomerSales() => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _SelectField(label: 'POS User', value: 'All'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _SelectField(label: 'Product', value: 'All'),
            ),
          ],
        ),
        const SizedBox(height: 9),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _DateField(
                link: _dateLink,
                date: _selectedDate,
                onTap: _showDatePicker,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 77,
              height: 42,
              child: ElevatedButton(
                onPressed: _showLoading,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2A40),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Show',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _SalesTable(date: _selectedDate),
      ],
    ),
  );

  Widget _buildZReports() => ListView(
    controller: _zReportsController,
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
    children: [
      if (_selectedZReport != null) _ZHistoryPanel(number: _selectedZReport!),
      _ZReport(
        number: '4515',
        lastZ: '#2\n2026-10-15 16:01:59',
        runBy: 'Manoj Kumar\n—',
        amount: null,
        history: true,
        selected: _selectedZReport == '4515',
        onHistoryTap: () => _selectZHistory('4515'),
      ),
      _ZReport(
        number: '4514',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '4514',
      ),
      _ZReport(
        number: '4513',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '4513',
      ),
      _ZReport(
        number: '4511',
        lastZ: '#1\n2026-06-08 10:54:25',
        runBy: 'Manoj Kumar\n—',
        amount: null,
        history: true,
        selected: _selectedZReport == '4511',
        onHistoryTap: () => _selectZHistory('4511'),
      ),
      _ZReport(
        number: '4443',
        lastZ: 'None yet',
        runBy: '—\n2026-08-31 13:16:30',
        amount: 'R119.50',
        selected: _selectedZReport == '4443',
      ),
      _ZReport(
        number: '4442',
        lastZ: '#7\n2026-01-30 10:54:07',
        runBy: 'gowtham i k\n—',
        amount: null,
        history: true,
        selected: _selectedZReport == '4442',
        onHistoryTap: () => _selectZHistory('4442'),
      ),
      _ZReport(
        number: '4441',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '4441',
      ),
      _ZReport(
        number: '4437',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '4437',
      ),
      _ZReport(
        number: '4435',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '4435',
      ),
      _ZReport(
        number: '2618',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '2618',
      ),
      _ZReport(
        number: '2617',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '2617',
      ),
      _ZReport(
        number: '2616',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '2616',
      ),
      _ZReport(
        number: '2615',
        lastZ: 'None yet',
        runBy: '—\n—',
        amount: null,
        selected: _selectedZReport == '2615',
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: SizedBox(
            width: 74,
            height: 40,
            child: ElevatedButton(
              onPressed: _goBack,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandRed,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text(
                'Back',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.onBack});
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => Container(
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 8),
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
              'Sales and Shift Report',
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

class _TabButton extends StatelessWidget {
  const _TabButton({
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
        foregroundColor: selected ? Colors.white : const Color(0xFF344258),
        elevation: selected ? 4 : 0,
        shadowColor: const Color(0x44C8102E),
        side: selected
            ? BorderSide.none
            : const BorderSide(color: Color(0xFFDDE5EE)),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    ),
  );
}

class _SelectField extends StatelessWidget {
  const _SelectField({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(color: Color(0xFF50627D), fontSize: 12),
      ),
      const SizedBox(height: 5),
      Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFC8D7E8)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Color(0xFF2C3A51), fontSize: 14),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 20),
          ],
        ),
      ),
    ],
  );
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.link,
    required this.date,
    required this.onTap,
  });
  final LayerLink link;
  final DateTime date;
  final VoidCallback onTap;
  String get text =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Date',
        style: TextStyle(color: Color(0xFF50627D), fontSize: 12),
      ),
      const SizedBox(height: 5),
      CompositedTransformTarget(
        link: link,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFC8D7E8)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xFF2C3A51),
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today_outlined, size: 16),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class _SalesTable extends StatelessWidget {
  const _SalesTable({required this.date});
  final DateTime date;
  static const products = [
    'Airtime',
    'Data',
    'Top it Up Easily',
    'VOIP',
    'Electricity',
    'Bills',
    'Money Transfer',
    'Global Airtime',
    'UNIPin',
    'Cash Management',
    'VAS',
  ];
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 11),
          child: Text(
            'Print Date: ${date.day} ${_monthNames[date.month - 1]} ${date.year} @15:27\nDemo Test Account (PTG999)\nTransaction Date:${date.day.toString().padLeft(2, '0')}–${date.month.toString().padLeft(2, '0')}–${date.year}',
            style: const TextStyle(
              color: Color(0xFF7287A6),
              fontSize: 11,
              height: 1.35,
            ),
          ),
        ),
        const Divider(height: 1),
        const _TableHeader(),
        ...products.map((product) => _ProductRow(product: product)),
        const _ProductRow(product: 'Total Sales', total: true),
      ],
    ),
  );
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.fromLTRB(16, 9, 16, 9),
    child: Row(
      children: [
        Expanded(
          child: Text(
            'PRODUCTS',
            style: TextStyle(
              color: Color(0xFF8498B6),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          'AMOUNT',
          style: TextStyle(
            color: Color(0xFF8498B6),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class _ProductRow extends StatelessWidget {
  const _ProductRow({required this.product, this.total = false});
  final String product;
  final bool total;
  @override
  Widget build(BuildContext context) => Container(
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFEAF0F5))),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            product,
            style: TextStyle(
              color: total ? AppColors.brandRed : const Color(0xFF42536C),
              fontSize: 14,
              fontWeight: total ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          'R0.00',
          style: TextStyle(
            color: total ? AppColors.brandRed : const Color(0xFF42536C),
            fontSize: 14,
            fontWeight: total ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

class _ZHistoryPanel extends StatelessWidget {
  const _ZHistoryPanel({required this.number});
  final String number;

  @override
  Widget build(BuildContext context) {
    final records = number == '4515'
        ? const [
            ('#2', '2026-10-15 16:01:59 · Manoj Kumar', 'R 145.00', '9 items'),
            ('#1', '2026-07-03 09:41:55 · Manoj Kumar', 'R 0.00', '0 items'),
          ]
        : [('#1', '2026-06-08 10:54:25 · Manoj Kumar', 'R 0.00', '0 items')];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFD),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE1E8F0)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 13, 14, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Z Reports: Top it Up #$number',
                    style: const TextStyle(
                      color: Color(0xFF1E2A40),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Text(
                  'All terminals',
                  style: TextStyle(
                    color: Color(0xFF1557E8),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...records.map(
            (record) => Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 9, 10, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE1E8F0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            record.$1,
                            style: const TextStyle(
                              color: Color(0xFF1E2A40),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            record.$2,
                            style: const TextStyle(
                              color: Color(0xFF7287A6),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          record.$3,
                          style: const TextStyle(
                            color: Color(0xFF11182B),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          record.$4,
                          style: const TextStyle(
                            color: Color(0xFF7287A6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ZReport extends StatelessWidget {
  const _ZReport({
    required this.number,
    required this.lastZ,
    required this.runBy,
    required this.amount,
    this.history = false,
    this.selected = false,
    this.onHistoryTap,
  });
  final String number;
  final String lastZ;
  final String runBy;
  final String? amount;
  final bool history;
  final bool selected;
  final VoidCallback? onHistoryTap;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      // The card outline stays neutral; only the left status accent changes
      // when this report's Z history is selected.
      border: Border.all(color: const Color(0xFFDDE5EE)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x081E3854),
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      children: [
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: DefaultTextStyle(
              style: const TextStyle(color: Color(0xFF11182B)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Top it Up #$number',
                          style: const TextStyle(
                            color: Color(0xFF11182B),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (amount != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'SINCE LAST Z',
                              style: TextStyle(
                                color: Color(0xFF50627D),
                                fontSize: 9,
                              ),
                            ),
                            Text(
                              amount!,
                              style: const TextStyle(
                                color: AppColors.brandRed,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _ZInfo(label: 'LAST Z', value: lastZ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: _ZInfo(
                          label: 'RUN BY / LAST SALE',
                          value: runBy,
                        ),
                      ),
                    ],
                  ),
                  if (history)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextButton.icon(
                        onPressed: onHistoryTap,
                        icon: const Icon(Icons.format_list_numbered, size: 14),
                        label: const Text('Z history'),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFF0F6FF),
                          foregroundColor: const Color(0xFF1557E8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 4,
          child: ColoredBox(
            color: selected ? AppColors.brandRed : Color(0xFF2864F0),
          ),
        ),
      ],
    ),
  );
}

class _ZInfo extends StatelessWidget {
  const _ZInfo({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 61),
    padding: const EdgeInsets.fromLTRB(9, 7, 6, 5),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFE6EDF4)),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF50627D), fontSize: 9),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF11182B),
            fontSize: 12,
            height: 1.35,
          ),
        ),
      ],
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

class _SalesCalendar extends StatefulWidget {
  const _SalesCalendar({
    required this.selectedDate,
    required this.onDateSelected,
    required this.onDismiss,
  });
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onDismiss;
  @override
  State<_SalesCalendar> createState() => _SalesCalendarState();
}

class _SalesCalendarState extends State<_SalesCalendar> {
  late DateTime _month;
  @override
  void initState() {
    super.initState();
    _month = DateTime(widget.selectedDate.year, widget.selectedDate.month);
  }

  void _changeMonth(int amount) =>
      setState(() => _month = DateTime(_month.year, _month.month + amount));

  @override
  Widget build(BuildContext context) {
    final firstOffset = DateTime(_month.year, _month.month, 1).weekday % 7;
    final days = DateTime(_month.year, _month.month + 1, 0).day;
    final previousDays = DateTime(_month.year, _month.month, 0).day;
    return Material(
      color: Colors.white,
      elevation: 8,
      child: SizedBox(
        width: 220,
        height: 282,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_monthNames[_month.month - 1]} ${_month.year}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _CalendarArrow(
                    icon: Icons.keyboard_arrow_up,
                    onTap: () => _changeMonth(-1),
                  ),
                  _CalendarArrow(
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => _changeMonth(1),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: _weekdays
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 3),
              SizedBox(
                height: 168,
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 42,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisExtent: 28,
                  ),
                  itemBuilder: (_, index) {
                    final day = index - firstOffset + 1;
                    final currentMonth = day >= 1 && day <= days;
                    final date = currentMonth
                        ? DateTime(_month.year, _month.month, day)
                        : day < 1
                        ? DateTime(
                            _month.year,
                            _month.month - 1,
                            previousDays + day,
                          )
                        : DateTime(_month.year, _month.month + 1, day - days);
                    final selected =
                        date.year == widget.selectedDate.year &&
                        date.month == widget.selectedDate.month &&
                        date.day == widget.selectedDate.day;
                    return Center(
                      child: GestureDetector(
                        onTap: () => widget.onDateSelected(date),
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected ? const Color(0xFF086BFF) : null,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            '${date.day}',
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : currentMonth
                                  ? const Color(0xFF222222)
                                  : const Color(0xFF858585),
                              fontSize: 12,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CalendarAction(label: 'Clear', onTap: widget.onDismiss),
                  _CalendarAction(
                    label: 'Today',
                    onTap: () => widget.onDateSelected(DateTime.now()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalendarArrow extends StatelessWidget {
  const _CalendarArrow({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: SizedBox(width: 28, height: 27, child: Icon(icon, size: 21)),
  );
}

class _CalendarAction extends StatelessWidget {
  const _CalendarAction({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFF006BFF), fontSize: 12),
      ),
    ),
  );
}

const _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
const _weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

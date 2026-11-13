import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class CommissionsAndInvoicesScreen extends StatefulWidget {
  const CommissionsAndInvoicesScreen({this.onBack, super.key});
  final VoidCallback? onBack;

  @override
  State<CommissionsAndInvoicesScreen> createState() =>
      _CommissionsAndInvoicesScreenState();
}

class _CommissionsAndInvoicesScreenState
    extends State<CommissionsAndInvoicesScreen> {
  static const navy = Color(0xFF1E2A40);
  static const muted = Color(0xFF7890B2);
  bool invoices = false;
  DateTime month = DateTime(2026, 10);
  DateTime? fromDate;
  DateTime? toDate;
  final LayerLink _monthLink = LayerLink();
  final LayerLink _fromLink = LayerLink();
  final LayerLink _toLink = LayerLink();
  OverlayEntry? _calendarEntry;

  String _date(DateTime? value) => value == null
      ? 'dd/mm/yyyy'
      : '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';

  Future<void> _loading() async {
    unawaited(
      showGeneralDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierLabel: 'Loading',
        barrierColor: const Color(0x99708091),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _LoadingDialog(),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _tab(bool value) async {
    await _loading();
    if (mounted) setState(() => invoices = value);
  }

  void _pick({required bool from}) {
    _openCalendar(
      link: from ? _fromLink : _toLink,
      alignRight: !from,
      selected: (from ? fromDate : toDate) ?? DateTime.now(),
      onSelected: (date) {
        setState(() => from ? fromDate = date : toDate = date);
        _closeCalendar();
      },
    );
  }

  void _pickMonth() {
    _closeCalendar();
    _calendarEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeCalendar,
            ),
          ),
          CompositedTransformFollower(
            link: _monthLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: const Offset(0, 7),
            child: _CommissionMonthPicker(
              selectedMonth: month,
              onMonthSelected: (selected) {
                setState(() => month = selected);
                _closeCalendar();
              },
              onDismiss: _closeCalendar,
            ),
          ),
        ],
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_calendarEntry!);
  }

  void _openCalendar({
    required LayerLink link,
    required DateTime selected,
    required ValueChanged<DateTime> onSelected,
    bool alignRight = false,
  }) {
    _closeCalendar();
    _calendarEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeCalendar,
            ),
          ),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            targetAnchor: alignRight
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            followerAnchor: alignRight ? Alignment.topRight : Alignment.topLeft,
            offset: const Offset(0, 7),
            child: _CommissionCalendar(
              selectedDate: selected,
              onDateSelected: onSelected,
              onDismiss: _closeCalendar,
            ),
          ),
        ],
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_calendarEntry!);
  }

  void _closeCalendar() {
    _calendarEntry?.remove();
    _calendarEntry = null;
  }

  @override
  void dispose() {
    _closeCalendar();
    super.dispose();
  }

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
      color: const Color(0xFFF5F8FC),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          children: [
            _TitleBar(onBack: _back),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _Tab(
                    label: 'Commissions',
                    active: !invoices,
                    onTap: () => _tab(false),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _Tab(
                    label: 'Invoices',
                    active: invoices,
                    onTap: () => _tab(true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            invoices ? _invoiceContent() : _commissionContent(),
          ],
        ),
      ),
    );
  }

  Widget _commissionContent() {
    final monthText = '${_months[month.month - 1]} ${month.year}';
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _DateField(
                value: monthText,
                onTap: _pickMonth,
                link: _monthLink,
              ),
            ),
            const SizedBox(width: 8),
            _ShowButton(onTap: _loading),
          ],
        ),
        const SizedBox(height: 16),
        const _CommissionCard(),
        const SizedBox(height: 16),
        _BackButton(onTap: _back),
      ],
    );
  }

  Widget _invoiceContent() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _LabeledDate(
                label: 'From Date',
                value: _date(fromDate),
                onTap: () => _pick(from: true),
                link: _fromLink,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _LabeledDate(
                label: 'To Date',
                value: _date(toDate),
                onTap: () => _pick(from: false),
                link: _toLink,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: _ShowButton(onTap: _loading, expanded: true),
        ),
        const SizedBox(height: 16),
        _InvoiceList(
          onInvoice: (id) => showDialog<void>(
            context: context,
            barrierColor: const Color(0x990D1220),
            builder: (_) => _TaxInvoice(invoice: id),
          ),
        ),
      ],
    );
  }
}

const _months = [
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
const _card = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(16)),
  border: Border.fromBorderSide(BorderSide(color: Color(0xFFDDE5ED))),
  boxShadow: [
    BoxShadow(color: Color(0x0A1E2A40), blurRadius: 12, offset: Offset(0, 5)),
  ],
);

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
      border: Border.all(color: const Color(0xFFE5EBF1)),
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
          'Commissions & Invoices',
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

class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: active ? AppColors.brandRed : Colors.white,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? AppColors.brandRed : const Color(0xFFD8E1EB),
          ),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x26C8102E),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF34445E),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

class _DateField extends StatelessWidget {
  const _DateField({required this.value, required this.onTap, this.link});
  final String value;
  final VoidCallback onTap;
  final LayerLink? link;
  @override
  Widget build(BuildContext context) {
    final field = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAFCFE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCAD8E6)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: _CommissionsAndInvoicesScreenState.navy,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: Color(0xFF111827),
            ),
          ],
        ),
      ),
    );
    return link == null
        ? field
        : CompositedTransformTarget(link: link!, child: field);
  }
}

class _LabeledDate extends StatelessWidget {
  const _LabeledDate({
    required this.label,
    required this.value,
    required this.onTap,
    required this.link,
  });
  final String label;
  final String value;
  final VoidCallback onTap;
  final LayerLink link;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: _CommissionsAndInvoicesScreenState.muted,
          fontSize: 12,
        ),
      ),
      const SizedBox(height: 5),
      _DateField(value: value, onTap: onTap, link: link),
    ],
  );
}

class _ShowButton extends StatelessWidget {
  const _ShowButton({required this.onTap, this.expanded = false});
  final VoidCallback onTap;
  final bool expanded;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: expanded ? double.infinity : 77,
    height: 42,
    child: FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: _CommissionsAndInvoicesScreenState.navy,
        foregroundColor: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Show',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class _CommissionCard extends StatelessWidget {
  const _CommissionCard();
  @override
  Widget build(BuildContext context) => Container(
    decoration: _card,
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 13, 15, 0),
          child: Text(
            'Monthly Commission Report',
            style: TextStyle(
              color: _CommissionsAndInvoicesScreenState.navy,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 2, 15, 0),
          child: Text(
            'Print Date: 13 November 2026 @08:29',
            style: TextStyle(
              color: _CommissionsAndInvoicesScreenState.muted,
              fontSize: 11,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 6, 15, 10),
          child: Text(
            'Demo Test Account (PTG999)\nCommission Date: October 2026',
            style: TextStyle(
              color: Color(0xFF34445E),
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ),
        Divider(height: 1, color: Color(0xFFE1E7EE)),
        _ReportRow(label: 'PRODUCTS', amount: 'COMMISSION', header: true),
        _ReportRow(label: 'Airtime', amount: 'R0.00'),
        _ReportRow(label: 'Electricity', amount: 'R0.00'),
        _ReportRow(label: 'Bills', amount: 'R0.00'),
        _ReportRow(label: 'Total Profit', amount: 'R0.00', total: true),
      ],
    ),
  );
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({
    required this.label,
    required this.amount,
    this.header = false,
    this.total = false,
  });
  final String label;
  final String amount;
  final bool header;
  final bool total;
  @override
  Widget build(BuildContext context) => Container(
    height: header ? 31 : 40,
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFE4E9EF))),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: header
                  ? _CommissionsAndInvoicesScreenState.muted
                  : total
                  ? AppColors.brandRed
                  : const Color(0xFF34445E),
              fontSize: header ? 11 : 14,
              fontWeight: total || header ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: header
                ? _CommissionsAndInvoicesScreenState.muted
                : total
                ? AppColors.brandRed
                : const Color(0xFF34445E),
            fontSize: header ? 11 : 14,
            fontWeight: total || header ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

class _InvoiceList extends StatelessWidget {
  const _InvoiceList({required this.onInvoice});
  final ValueChanged<String> onInvoice;
  static const rows = [
    ('2026-07-12', 'IN0000077060', '36928.45'),
    ('2026-07-12', 'IN0000077058', '36928.45'),
    ('2014-05-18', 'IN0000077050', '1162.00'),
    ('2014-05-18', 'IN0000076700', '412.00'),
    ('2014-05-04', 'IN0000074855', '271.00'),
    ('2014-04-27', 'IN0000073938', '238.00'),
    ('2014-04-20', 'IN0000073727', '200.00'),
  ];
  @override
  Widget build(BuildContext context) => Container(
    decoration: _card,
    child: Column(
      children: [
        const _InvoiceHeader(),
        ...rows.map(
          (row) => InkWell(
            onTap: () => onInvoice(row.$2),
            child: _InvoiceRow(date: row.$1, number: row.$2, amount: row.$3),
          ),
        ),
      ],
    ),
  );
}

class _InvoiceHeader extends StatelessWidget {
  const _InvoiceHeader();
  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 32,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'INVOICES',
              style: TextStyle(
                color: _CommissionsAndInvoicesScreenState.muted,
                fontSize: 11,
              ),
            ),
          ),
          Text(
            'AMOUNT',
            style: TextStyle(
              color: _CommissionsAndInvoicesScreenState.muted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}

class _InvoiceRow extends StatelessWidget {
  const _InvoiceRow({
    required this.date,
    required this.number,
    required this.amount,
  });
  final String date;
  final String number;
  final String amount;
  @override
  Widget build(BuildContext context) => Container(
    height: 60,
    padding: const EdgeInsets.fromLTRB(15, 8, 15, 6),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFE4E9EF))),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: const TextStyle(
                  color: _CommissionsAndInvoicesScreenState.muted,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                number,
                style: const TextStyle(
                  color: _CommissionsAndInvoicesScreenState.navy,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: const TextStyle(color: Color(0xFF34445E), fontSize: 14),
        ),
      ],
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

class _CommissionMonthPicker extends StatefulWidget {
  const _CommissionMonthPicker({
    required this.selectedMonth,
    required this.onMonthSelected,
    required this.onDismiss,
  });

  final DateTime selectedMonth;
  final ValueChanged<DateTime> onMonthSelected;
  final VoidCallback onDismiss;

  @override
  State<_CommissionMonthPicker> createState() => _CommissionMonthPickerState();
}

class _CommissionMonthPickerState extends State<_CommissionMonthPicker> {
  late int _year;

  @override
  void initState() {
    super.initState();
    _year = widget.selectedMonth.year;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 8,
      shadowColor: const Color(0x401E2A40),
      child: SizedBox(
        width: 220,
        height: 250,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '$_year',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _CalendarArrow(
                    icon: Icons.keyboard_arrow_up,
                    onTap: () => setState(() => _year--),
                  ),
                  _CalendarArrow(
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => setState(() => _year++),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 30,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    final selected =
                        _year == widget.selectedMonth.year &&
                        index + 1 == widget.selectedMonth.month;
                    return InkWell(
                      onTap: () =>
                          widget.onMonthSelected(DateTime(_year, index + 1)),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF086BFF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _months[index].substring(0, 3),
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : const Color(0xFF222222),
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: _CalendarAction(label: 'Clear', onTap: widget.onDismiss),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommissionCalendar extends StatefulWidget {
  const _CommissionCalendar({
    required this.selectedDate,
    required this.onDateSelected,
    required this.onDismiss,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onDismiss;

  @override
  State<_CommissionCalendar> createState() => _CommissionCalendarState();
}

class _CommissionCalendarState extends State<_CommissionCalendar> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    _month = DateTime(widget.selectedDate.year, widget.selectedDate.month);
  }

  @override
  Widget build(BuildContext context) {
    final firstOffset = DateTime(_month.year, _month.month, 1).weekday % 7;
    final days = DateTime(_month.year, _month.month + 1, 0).day;
    final previousDays = DateTime(_month.year, _month.month, 0).day;

    return Material(
      color: Colors.white,
      elevation: 8,
      shadowColor: const Color(0x401E2A40),
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
                      '${_months[_month.month - 1]} ${_month.year}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _CalendarArrow(
                    icon: Icons.keyboard_arrow_up,
                    onTap: () => setState(() {
                      _month = DateTime(_month.year, _month.month - 1);
                    }),
                  ),
                  _CalendarArrow(
                    icon: Icons.keyboard_arrow_down,
                    onTap: () => setState(() {
                      _month = DateTime(_month.year, _month.month + 1);
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
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
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 42,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisExtent: 28,
                  ),
                  itemBuilder: (context, index) {
                    final number = index - firstOffset + 1;
                    final current = number >= 1 && number <= days;
                    final date = current
                        ? DateTime(_month.year, _month.month, number)
                        : number < 1
                        ? DateTime(
                            _month.year,
                            _month.month - 1,
                            previousDays + number,
                          )
                        : DateTime(
                            _month.year,
                            _month.month + 1,
                            number - days,
                          );
                    final selected =
                        date.year == widget.selectedDate.year &&
                        date.month == widget.selectedDate.month &&
                        date.day == widget.selectedDate.day;
                    return Center(
                      child: InkWell(
                        onTap: () => widget.onDateSelected(date),
                        borderRadius: BorderRadius.circular(2),
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF086BFF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            '$number',
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : current
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

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();
  @override
  Widget build(BuildContext context) => Center(
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      child: const SizedBox(
        width: 206,
        height: 161,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 44,
              height: 44,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Color(0xFF165DFF),
                backgroundColor: Color(0xFFDCEAFF),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Please wait...',
              style: TextStyle(
                color: Color(0xFF0E2442),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 7),
            Text(
              'Loading page',
              style: TextStyle(color: Color(0xFF7385A1), fontSize: 13),
            ),
          ],
        ),
      ),
    ),
  );
}

class _TaxInvoice extends StatelessWidget {
  const _TaxInvoice({required this.invoice});
  final String invoice;
  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: Colors.white,
    insetPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 90),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: SizedBox(
      height: 458,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Tax Invoice',
                    style: TextStyle(
                      color: _CommissionsAndInvoicesScreenState.navy,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, size: 13),
                  label: const Text('PDF'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _CommissionsAndInvoicesScreenState.navy,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(60, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFFF0F5FA),
                    foregroundColor: _CommissionsAndInvoicesScreenState.navy,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE1E7EE)),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PaperHeader(invoice: invoice),
                  const SizedBox(height: 10),
                  const Text(
                    'Airtime & Electricity',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5),
                  const _InvoiceTable(),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount Due',
                        style: TextStyle(
                          color: Color(0xFF9D0E20),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'R 0.00',
                        style: TextStyle(
                          color: Color(0xFF9D0E20),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF9D0E20)),
                  const Text(
                    'Payment Details   Your Reference: PTG999',
                    style: TextStyle(
                      color: Color(0xFF9D0E20),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Cash Deposit, ATM or EFT Nedbank - Top it Up\nCash Deposit, ATM or EFT ABSA - Top it Up',
                    style: TextStyle(fontSize: 11, height: 1.5),
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

class _PaperHeader extends StatelessWidget {
  const _PaperHeader({required this.invoice});
  final String invoice;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Tax Invoice#: $invoice',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      const Text(
        '9 July 2026, 00h00 to 12 July 2026, 23h59',
        style: TextStyle(fontSize: 11),
      ),
      const Divider(color: AppColors.brandRed),
      const Text('Top it Up', style: TextStyle(fontWeight: FontWeight.w700)),
      const Text(
        '15 Castleton Road, Wynberg,\nCape Town, South Africa, 7800\nTel: 0860 111 723\nWhatsapp No: 064 121 9970\nReg No: 2018/035562/07\nVat Reg. No: 4380255242\nEmail: info@topitup.co.za\nWebsite: www.topitup.co.za',
        style: TextStyle(fontSize: 11, height: 1.4),
      ),
      const Divider(color: AppColors.brandRed),
    ],
  );
}

class _InvoiceTable extends StatelessWidget {
  const _InvoiceTable();
  @override
  Widget build(BuildContext context) => Table(
    border: TableBorder.all(color: const Color(0xFFB71C2B)),
    children: const [
      TableRow(
        decoration: BoxDecoration(color: Color(0xFF8E0B1B)),
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'ITEM CODE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'DESCRIPTION',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'QTY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'SALES PRICE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      TableRow(
        children: [
          SizedBox(height: 34),
          SizedBox(height: 34),
          SizedBox(height: 34),
          SizedBox(height: 34),
        ],
      ),
    ],
  );
}

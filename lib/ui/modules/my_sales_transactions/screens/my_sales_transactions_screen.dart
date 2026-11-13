import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class MySalesTransactionsScreen extends StatefulWidget {
  const MySalesTransactionsScreen({this.onBack, super.key});

  final VoidCallback? onBack;

  @override
  State<MySalesTransactionsScreen> createState() =>
      _MySalesTransactionsScreenState();
}

class _MySalesTransactionsScreenState extends State<MySalesTransactionsScreen> {
  static const _navy = Color(0xFF1E2A40);
  static const _mutedText = Color(0xFF7287A6);

  bool _showSummary = false;
  DateTime _selectedDate = DateTime.now();
  final LayerLink _dateFieldLink = LayerLink();
  OverlayEntry? _datePickerEntry;

  String get _formattedDate {
    final day = _selectedDate.day.toString().padLeft(2, '0');
    final month = _selectedDate.month.toString().padLeft(2, '0');
    return '$day/$month/${_selectedDate.year}';
  }

  String get _summaryHeading {
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final date = _formattedDate.replaceAll('/', '–');
    return '${weekdays[_selectedDate.weekday - 1]}, $date';
  }

  Future<void> _selectSection(bool showSummary) async {
    await _showLoadingOverlay();
    if (mounted) setState(() => _showSummary = showSummary);
  }

  Future<void> _showLoadingOverlay() async {
    unawaited(
      showGeneralDialog<void>(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        barrierLabel: 'Loading',
        barrierColor: const Color(0x99708091),
        transitionDuration: const Duration(milliseconds: 160),
        pageBuilder: (dialogContext, animation, secondaryAnimation) {
          return const _LoadingDialog();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: ScaleTransition(
              scale: Tween(begin: .96, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _toggleDatePicker() {
    if (_datePickerEntry != null) {
      _closeDatePicker();
      return;
    }

    final entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeDatePicker,
            ),
          ),
          CompositedTransformFollower(
            link: _dateFieldLink,
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
    _datePickerEntry = entry;
    Overlay.of(context, rootOverlay: true).insert(entry);
  }

  void _closeDatePicker() {
    _datePickerEntry?.remove();
    _datePickerEntry = null;
  }

  @override
  void dispose() {
    _closeDatePicker();
    super.dispose();
  }

  Future<void> _refresh() => _showLoadingOverlay();

  void _goBack() {
    if (widget.onBack != null) {
      widget.onBack!();
      return;
    }
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF5F8FC),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          children: [
            _buildTitleBar(),
            const SizedBox(height: 16),
            _buildSectionToggle(),
            const SizedBox(height: 16),
            _buildDateRow(),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: _showSummary
                  ? _buildSummaryContent()
                  : _buildTransactionsContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      key: const Key('sales-title-header'),
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
            'Sales Transactions',
            style: TextStyle(
              color: Color(0xFF11182B),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Positioned(
            left: 8,
            child: _TitleIconButton(
              icon: Icons.arrow_back,
              color: const Color(0xFF28415C),
              backgroundColor: const Color(0xFFF0F6FA),
              onTap: _goBack,
            ),
          ),
          Positioned(
            right: 8,
            child: _TitleIconButton(
              icon: Icons.home_outlined,
              color: AppColors.brandRed,
              backgroundColor: const Color(0xFFFFF0F2),
              onTap: _goBack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionToggle() {
    return Row(
      children: [
        Expanded(
          child: _SectionButton(
            label: 'Sales Transaction',
            selected: !_showSummary,
            onTap: () => _selectSection(false),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SectionButton(
            label: 'Sales Summary',
            selected: _showSummary,
            onTap: () => _selectSection(true),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow() {
    return Row(
      children: [
        Expanded(
          child: CompositedTransformTarget(
            link: _dateFieldLink,
            child: InkWell(
              key: const Key('sales-date-picker'),
              onTap: _toggleDatePicker,
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
                        _formattedDate,
                        style: const TextStyle(
                          color: _navy,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 77,
          height: 42,
          child: FilledButton(
            key: const Key('sales-show-button'),
            onPressed: _refresh,
            style: FilledButton.styleFrom(
              backgroundColor: _navy,
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Show',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsContent() {
    return Column(
      key: const ValueKey('transactions'),
      children: [
        const _EmptyRecordCard(title: 'Sales'),
        const SizedBox(height: 16),
        const _EmptyRecordCard(title: 'Card Acceptance'),
        const SizedBox(height: 16),
        const _EmptyRecordCard(title: 'Supplier Payments'),
        const SizedBox(height: 16),
        _BackButton(onPressed: _goBack),
      ],
    );
  }

  Widget _buildSummaryContent() {
    return Column(
      key: const ValueKey('summary'),
      children: [
        _EmptyRecordCard(title: _summaryHeading),
        const SizedBox(height: 16),
        _BackButton(onPressed: _goBack),
      ],
    );
  }
}

class _TitleIconButton extends StatelessWidget {
  const _TitleIconButton({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, size: 21, color: color),
        ),
      ),
    );
  }
}

class _SectionButton extends StatelessWidget {
  const _SectionButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.brandRed : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.brandRed : const Color(0xFFD8E1EB),
            ),
            boxShadow: selected
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
              color: selected ? Colors.white : const Color(0xFF34445E),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyRecordCard extends StatelessWidget {
  const _EmptyRecordCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE5ED)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1E2A40),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 44,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _MySalesTransactionsScreenState._navy,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const Divider(color: Color(0xFFE2E8F0), height: 1),
          const Expanded(
            child: Center(
              child: Text(
                'No Records Found',
                style: TextStyle(
                  color: _MySalesTransactionsScreenState._mutedText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.brandRed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 21),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: const Text(
          'Back',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
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

  void _changeMonth(int amount) {
    setState(() {
      _month = DateTime(_month.year, _month.month + amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDayOffset = DateTime(_month.year, _month.month, 1).weekday % 7;
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    final daysInPreviousMonth = DateTime(_month.year, _month.month, 0).day;
    final monthName = _monthNames[_month.month - 1];

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
                      '$monthName ${_month.year}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
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
                    .map((day) => Expanded(child: _CalendarLabel(day)))
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
                    final dayNumber = index - firstDayOffset + 1;
                    final isCurrentMonth =
                        dayNumber >= 1 && dayNumber <= daysInMonth;
                    final date = isCurrentMonth
                        ? DateTime(_month.year, _month.month, dayNumber)
                        : dayNumber < 1
                        ? DateTime(
                            _month.year,
                            _month.month - 1,
                            daysInPreviousMonth + dayNumber,
                          )
                        : DateTime(
                            _month.year,
                            _month.month + 1,
                            dayNumber - daysInMonth,
                          );
                    final isSelected =
                        date.year == widget.selectedDate.year &&
                        date.month == widget.selectedDate.month &&
                        date.day == widget.selectedDate.day;
                    return _CalendarDay(
                      date: date,
                      isCurrentMonth: isCurrentMonth,
                      isSelected: isSelected,
                      onTap: () => widget.onDateSelected(date),
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

class _CalendarArrow extends StatelessWidget {
  const _CalendarArrow({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 27,
        child: Icon(icon, color: const Color(0xFF202020), size: 21),
      ),
    );
  }
}

class _CalendarLabel extends StatelessWidget {
  const _CalendarLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF202020),
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _CalendarAction extends StatelessWidget {
  const _CalendarAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF006BFF),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.date,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime date;
  final bool isCurrentMonth;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(2),
        child: Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF086BFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : isCurrentMonth
                  ? const Color(0xFF222222)
                  : const Color(0xFF858585),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Center(
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
}

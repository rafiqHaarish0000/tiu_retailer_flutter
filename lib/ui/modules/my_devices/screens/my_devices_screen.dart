import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class MyDevicesScreen extends StatelessWidget {
  const MyDevicesScreen({this.onBack, super.key});
  final VoidCallback? onBack;
  void _goBack(BuildContext context) {
    if (onBack != null) {
      onBack!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: const Color(0xFFF5F8FC),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
          child: _Title(onBack: () => _goBack(context)),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              children: [
                _DeviceList(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _PageButton('‹  Prev', false),
                    const Text(
                      'Page 1 of 4 (36 records)',
                      style: TextStyle(color: Color(0xFF7287A6), fontSize: 11),
                    ),
                    const _PageButton('Next  ›', true),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(color: const Color(0xFFE1E8F0)),
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => _goBack(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 11,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _Title extends StatelessWidget {
  const _Title({required this.onBack});
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
        _Icon(
          Icons.arrow_back,
          const Color(0xFFF0F6FA),
          const Color(0xFF28415C),
          onBack,
        ),
        const Expanded(
          child: Center(
            child: Text(
              'My Devices',
              style: TextStyle(
                color: Color(0xFF11182B),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        _Icon(
          Icons.home_outlined,
          const Color(0xFFFFF0F2),
          AppColors.brandRed,
          onBack,
        ),
      ],
    ),
  );
}

class _Icon extends StatelessWidget {
  const _Icon(this.icon, this.bg, this.fg, this.onTap);
  final IconData icon;
  final Color bg;
  final Color fg;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: bg,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, color: fg, size: 21),
      ),
    ),
  );
}

class _DeviceList extends StatelessWidget {
  final devices = const <_Device>[
    _Device(
      'IDT700 II – Dual SIM',
      'Terminal',
      '700120821021',
      '2021–09–17',
      'Suhail Parkar',
      'IDT 700 II',
      '516',
    ),
    _Device(
      'IDT700',
      'Terminal',
      '7000111003021',
      '2023–12–19',
      'Suhail Parkar',
      'IDT700',
      '4437',
    ),
    _Device(
      'IDT700',
      'Terminal',
      '7000111003022',
      '2017–02–27',
      'Suhail Parkar',
      'IDT700',
      '3728',
    ),
    _Device(
      'IDT700',
      'Terminal',
      '7000111003030',
      '2019–06–17',
      'Suhail Parkar',
      'IDT700',
      '3664',
    ),
    _Device(
      'Wintec',
      'Antenna',
      'SA10075',
      '-',
      'Areef Dullah',
      'wintec new',
      '4063',
    ),
    _Device(
      'Wintec',
      'Antenna',
      'SA10072',
      '-',
      'Areef Dullah',
      'wintec new',
      '4090',
    ),
    _Device(
      'Vodacom Prepaid',
      'SIM Card',
      '89450000000017496347',
      '-',
      'Nazeem Holmes',
      '3OMB',
      '514',
    ),
    _Device(
      'Wintec',
      'Antenna',
      'SA10035',
      '-',
      'Areef Dullah',
      'wintec new',
      '4507',
    ),
    _Device(
      'Wintec',
      'Antenna',
      'SA10058',
      '-',
      'Areef Dullah',
      'wintec new',
      '3931',
    ),
    _Device(
      'Vodacom',
      '3G Dongle',
      '320A231413A8',
      '-',
      'Gershwin Marco',
      'CE1588',
      '4347',
    ),
  ];
  @override
  Widget build(BuildContext context) => Container(
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.brandRed, Color(0xFFE97900)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.phone_android,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Devices currently assigned to your store',
                style: TextStyle(color: Color(0xFF7287A6), fontSize: 12),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        ...devices.map((device) => _DeviceRow(device: device)),
      ],
    ),
  );
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow({required this.device});
  final _Device device;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 13, 16, 12),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFEAF0F5))),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                device.name,
                style: const TextStyle(
                  color: Color(0xFF11182B),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${device.days} days',
                style: const TextStyle(
                  color: Color(0xFFE56B00),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          device.type,
          style: const TextStyle(color: Color(0xFF7287A6), fontSize: 11),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: Text(
                'Serial: ${device.serial}\nUser: ${device.user}',
                style: const TextStyle(
                  color: Color(0xFF7287A6),
                  fontSize: 11,
                  height: 1.45,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Assigned: ${device.assigned}\nADSL: ${device.adsl}',
                style: const TextStyle(
                  color: Color(0xFF8EA1BC),
                  fontSize: 11,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _PageButton extends StatelessWidget {
  const _PageButton(this.label, this.enabled);
  final String label;
  final bool enabled;
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: enabled ? () {} : null,
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFFEAF1F8),
      foregroundColor: const Color(0xFF7287A6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      minimumSize: Size.zero,
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );
}

class _Device {
  const _Device(
    this.name,
    this.type,
    this.serial,
    this.assigned,
    this.user,
    this.adsl,
    this.days,
  );
  final String name, type, serial, assigned, user, adsl, days;
}

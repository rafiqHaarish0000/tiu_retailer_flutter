import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class DeviceStolenScreen extends StatelessWidget {
  const DeviceStolenScreen({super.key});
  static const devices = [
    ('IDT700 II – Dual SIM', '700120821021'),
    ('IDT700', '7000111003021'),
    ('IDT700', '7000111003022'),
    ('IDT700', '7000111003030'),
    ('IDT700', '1MB7000110820325'),
    ('Android WPOS3', 'PP35272137000852'),
    ('Android WPOS3', 'PP35272139000959'),
    ('Android WPOS3', 'PP35272204001818'),
  ];

  @override
  Widget build(BuildContext context) => _ReportDialog(devices: devices);
}

class _ReportDialog extends StatefulWidget {
  const _ReportDialog({required this.devices});
  final List<(String, String)> devices;
  @override
  State<_ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<_ReportDialog> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) => Dialog(
    insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    child: SizedBox(
      height: 745,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 12, 13),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8EB),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: AppColors.brandRed,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report Stolen Device',
                        style: TextStyle(
                          color: Color(0xFF1E2A40),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Emergency account suspension',
                        style: TextStyle(
                          color: AppColors.brandRed,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF8EA1BC),
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 16, 18, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'If one of your store terminals or tablets is lost or stolen,\nselect it below to immediately suspend your store.',
                style: TextStyle(
                  color: Color(0xFF7287A6),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: widget.devices.length,
              itemBuilder: (_, index) {
                final device = widget.devices[index];
                return _DeviceChoice(
                  name: device.$1,
                  serial: device.$2,
                  selected: _selected == index,
                  onTap: () => setState(() => _selected = index),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF344761),
                      side: const BorderSide(color: Color(0xFFE1E8F0)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.lock_outline, size: 16),
                    label: const Text('Report & Suspend'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandRed,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _DeviceChoice extends StatelessWidget {
  const _DeviceChoice({
    required this.name,
    required this.serial,
    required this.selected,
    required this.onTap,
  });
  final String name;
  final String serial;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15),
    child: Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E8F0)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: selected ? const Color(0xFF1877FF) : const Color(0xFF7B8188),
            size: 21,
          ),
          const SizedBox(width: 8),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FF),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF9BC4FF)),
            ),
            child: const Icon(
              Icons.dialpad,
              color: Color(0xFF2878FF),
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF1E2A40),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Serial:  $serial',
                  style: const TextStyle(
                    color: Color(0xFF7287A6),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDCEAFF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'POS Terminal',
              style: TextStyle(
                color: Color(0xFF1E4A83),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

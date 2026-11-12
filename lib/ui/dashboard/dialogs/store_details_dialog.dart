part of '../screens/dashboard_screen.dart';

class _StoreDetailsDialog extends StatelessWidget {
  const _StoreDetailsDialog();

  static const _text = Color(0xFF18233A);
  static const _label = Color(0xFF8A9AB3);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 22, 25, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.info, color: Color(0xFF159B78), size: 18),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Store Details',
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
            const SizedBox(height: 16),
            const _StoreDetailField(
              label: 'TRADING ENTITY',
              value: 'Demo Test Account',
            ),
            const SizedBox(height: 12),
            const _StoreDetailField(label: 'ACCOUNTNUMBER', value: 'PTG999'),
            const SizedBox(height: 12),
            const _StoreDetailField(
              label: 'PHYSICAL ADDRESS',
              value: 'address1, address1, Cape Town, Cape\nTown',
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 37,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111A2F),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Done',
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

class _StoreDetailField extends StatelessWidget {
  const _StoreDetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: _StoreDetailsDialog._label,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              color: _StoreDetailsDialog._text,
              fontSize: 14,
              height: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

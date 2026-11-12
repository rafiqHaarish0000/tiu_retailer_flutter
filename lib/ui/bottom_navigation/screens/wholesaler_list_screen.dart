part of '../../dashboard/screens/dashboard_screen.dart';

class _WholesalerListPage extends StatelessWidget {
  const _WholesalerListPage({required this.onBack, required this.onPlaceOrder});

  final VoidCallback onBack;
  final VoidCallback onPlaceOrder;

  @override
  Widget build(BuildContext context) {
    const suppliers = [
      ('AT', 'Aishwarya Traders', 'Terrace:2343243243', 'WAYANAD, Cape'),
      ('TW', 'Tobacco\nWholeSalers', 'Road:Church Hermanus,', 'Overstrand'),
      ('TI', 'Top It Up\nWholesale', 'Road:15 Castleton', 'Wynberg, Cape Town'),
      ('TS', 'test supplier', 'Terrace: jjkl', 'WAYANAD, WAYANAD'),
    ];
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _backButton(onBack),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order from Wholesalers',
                          style: TextStyle(
                            color: Color(0xFF18233A),
                            fontSize: 16,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Wholesale Direct Ordering • Real-Time Stock & Prices',
                          style: TextStyle(
                            color: Color(0xFF607696),
                            fontSize: 10,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEEEE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '• 4 Partners',
                      style: TextStyle(
                        color: Color(0xFFC81920),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _searchBox('Search by wholesaler name, location or contact'),
              const SizedBox(height: 16),
              ...suppliers.map(
                (supplier) => Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: _WholesalerCard(
                    supplier: supplier,
                    onPlaceOrder: onPlaceOrder,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Positioned(right: 12, bottom: 14, child: _SupplierCartButton()),
      ],
    );
  }
}

class _WholesalerCard extends StatefulWidget {
  const _WholesalerCard({required this.supplier, required this.onPlaceOrder});
  final (String, String, String, String) supplier;
  final VoidCallback onPlaceOrder;

  @override
  State<_WholesalerCard> createState() => _WholesalerCardState();
}

class _WholesalerCardState extends State<_WholesalerCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 138),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDDE5EE)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x101E3854),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D3FE9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(color: Color(0x22000000), blurRadius: 4),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.supplier.$1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.supplier.$2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF18233A),
                      fontSize: 14,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    color: const Color(0xFFE4FAF1),
                    child: const Text(
                      'Verified',
                      style: TextStyle(
                        color: Color(0xFF168A63),
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.supplier.$3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF52677D),
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                  Text(
                    widget.supplier.$4,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF52677D),
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 118,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite
                            ? const Color(0xFFE52435)
                            : const Color(0xFFC4D2E2),
                        size: 23,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: widget.onPlaceOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC81920),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(104, 36),
                      fixedSize: const Size(104, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Place Order'),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward, size: 15),
                      ],
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
}

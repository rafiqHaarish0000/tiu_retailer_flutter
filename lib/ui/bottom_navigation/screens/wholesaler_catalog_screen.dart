part of '../../dashboard/screens/dashboard_screen.dart';

class _WholesalerCatalogPage extends StatelessWidget {
  const _WholesalerCatalogPage({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _backButton(onBack),
                  const SizedBox(width: 13),
                  const Text(
                    'Aishwarya Traders',
                    style: TextStyle(
                      color: Color(0xFF18233A),
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _searchBox(
                'Search products in Aishwarya Traders',
                showButton: true,
              ),
              const SizedBox(height: 17),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop by Category',
                    style: TextStyle(
                      color: Color(0xFF18233A),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '8 Departments',
                    style: TextStyle(color: Color(0xFF8195B1), fontSize: 10),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Explore departments & products',
                style: TextStyle(color: Color(0xFF9AAAC0), fontSize: 10),
              ),
              const SizedBox(height: 12),
              const _CategoryGrid(),
              const SizedBox(height: 25),
              const _MostSellingSection(),
              const SizedBox(height: 25),
              const _OrderAgainSection(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();
  @override
  Widget build(BuildContext context) {
    const labels = [
      'All Products',
      'Beverages',
      'Cleaning Supplies',
      'Food & Beverages',
      'Grocery',
      'Personal Care',
      'Processed Foods',
      'Snacks',
      'Staples & Grains',
    ];
    const icons = [
      Icons.grid_view,
      Icons.local_drink,
      Icons.cleaning_services,
      Icons.local_fire_department,
      Icons.shopping_basket,
      Icons.local_florist,
      Icons.sell_outlined,
      Icons.fastfood,
      Icons.rice_bowl,
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: labels.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: .9,
      ),
      itemBuilder: (_, i) => Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: i == 0 ? const Color(0xFFFFF9EF) : const Color(0xFFF0F5FC),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: i == 0
                    ? const Color(0xFF18233A)
                    : const Color(0xFFDDE5EE),
              ),
            ),
            child: Icon(
              icons[i],
              color: i == 0 ? const Color(0xFFC81920) : const Color(0xFF4C8FEF),
              size: 25,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            labels[i],
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              color: Color(0xFF354863),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '(${i + 1})',
            style: const TextStyle(color: Color(0xFF94A7C0), fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class _MostSellingSection extends StatefulWidget {
  const _MostSellingSection();

  @override
  State<_MostSellingSection> createState() => _MostSellingSectionState();
}

class _MostSellingSectionState extends State<_MostSellingSection> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;

  static const _products = [
    (
      'cane juice',
      '500 ml',
      'R 18.50',
      'https://images.unsplash.com/photo-1578167635645-32c0d67e8b4e?auto=format&fit=crop&w=500&q=80',
    ),
    (
      'Lemon Juice 2L',
      '2L',
      'R 25.50',
      'https://images.unsplash.com/photo-1546173159-315724a31696?auto=format&fit=crop&w=500&q=80',
    ),
    (
      'Orange Juice',
      '1L',
      'R 22.00',
      'https://images.unsplash.com/photo-1600271886742-f049cd451bba?auto=format&fit=crop&w=500&q=80',
    ),
    (
      'Berry Smoothie',
      '750 ml',
      'R 32.90',
      'https://images.unsplash.com/photo-1553530666-ba11a7da3888?auto=format&fit=crop&w=500&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_scrollController.hasClients) return;
      final position = _scrollController.position;
      final nextOffset = position.pixels >= position.maxScrollExtent - 8
          ? 0.0
          : (position.pixels + 174).clamp(0.0, position.maxScrollExtent);
      _scrollController.animateTo(
        nextOffset,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 17,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xFFFFF4F4),
              borderRadius: BorderRadius.all(Radius.circular(9)),
              border: Border.fromBorderSide(
                BorderSide(color: Color(0xFFD71920)),
              ),
            ),
            child: Icon(
              Icons.local_fire_department,
              color: Color(0xFFD71920),
              size: 12,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Most Selling Products',
              style: TextStyle(
                color: Color(0xFF18233A),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See All',
                style: TextStyle(
                  color: Color(0xFFC81920),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 3),
              Icon(Icons.chevron_right, color: Color(0xFFC81920), size: 20),
            ],
          ),
        ],
      ),
      const Padding(
        padding: EdgeInsets.only(left: 25),
        child: Text(
          'Top popular picks from Aishwarya Traders',
          style: TextStyle(color: Color(0xFF8A9AB3), fontSize: 10),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: 239,
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: _products.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final product = _products[index];
            return SizedBox(
              width: 164,
              child: _CatalogProductCard(
                title: product.$1,
                amount: product.$2,
                price: product.$3,
                imageUrl: product.$4,
              ),
            );
          },
        ),
      ),
    ],
  );
}

class _CatalogProductCard extends StatefulWidget {
  const _CatalogProductCard({
    required this.title,
    required this.amount,
    required this.price,
    required this.imageUrl,
  });
  final String title, amount, price, imageUrl;

  @override
  State<_CatalogProductCard> createState() => _CatalogProductCardState();
}

class _CatalogProductCardState extends State<_CatalogProductCard> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFFDDE5EE)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x101E3854),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 126,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(9, 9, 9, 0),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F7FA),
                borderRadius: BorderRadius.circular(9),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const Icon(Icons.image_not_supported_outlined, size: 45),
              ),
            ),
            Positioned(
              top: 5,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFD21E27),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Text(
                  'TOP SELLER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1C7),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.amount,
                  style: const TextStyle(
                    color: Color(0xFF9A6300),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(11, 9, 11, 0),
          child: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF18233A),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(11, 4, 11, 7),
          child: Text(
            widget.amount,
            style: const TextStyle(color: Color(0xFF8195B1), fontSize: 9),
          ),
        ),
        const Divider(color: Color(0xFFE6ECF2), height: 1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: widget.price.startsWith('R')
                          ? const Color(0xFF18233A)
                          : const Color(0xFF607696),
                      fontSize: widget.price.startsWith('R') ? 14 : 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _quantity++),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 31,
                    height: 31,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3F3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFFD1D1)),
                    ),
                    child: Center(
                      child: _quantity == 0
                          ? const Icon(
                              Icons.add,
                              color: Color(0xFFD71920),
                              size: 19,
                            )
                          : Text(
                              '$_quantity',
                              style: const TextStyle(
                                color: Color(0xFFD71920),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
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

class _OrderAgainSection extends StatelessWidget {
  const _OrderAgainSection();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFDDE5EE)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Again',
              style: TextStyle(
                color: Color(0xFF18233A),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '● RECENT',
              style: TextStyle(
                color: Color(0xFF159B78),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const Text(
          'Order history & fast 1-click reorder',
          style: TextStyle(color: Color(0xFF8A9AB3), fontSize: 10),
        ),
        const SizedBox(height: 12),
        const _OrderAgainCard(
          order: 'Order SO-20261103-0006 • 2 Items',
          status: '03 Nov, 09:35',
          price: 'R 105.97',
          imageCount: 2,
        ),
        const _OrderAgainCard(
          order: 'Order SO-20261103-0005 • 3 Items',
          status: '03 Nov, 09:19',
          price: 'R 100.00',
          imageCount: 3,
        ),
        const _OrderAgainCard(
          order: 'Order SO-20261103-0003 • 1 Item',
          status: '03 Nov, 08:55',
          price: 'R 63.00',
          imageCount: 1,
        ),
      ],
    ),
  );
}

class _OrderAgainCard extends StatelessWidget {
  const _OrderAgainCard({
    required this.order,
    required this.status,
    required this.price,
    required this.imageCount,
  });

  final String order;
  final String status;
  final String price;
  final int imageCount;

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?auto=format&fit=crop&w=160&q=75';
    return Container(
      height: 118,
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.fromLTRB(12, 13, 12, 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: const Color(0xFFDDE5EE)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: imageCount * 25.0,
                height: 31,
                child: Stack(
                  children: List.generate(
                    imageCount,
                    (index) => Positioned(
                      left: index * 22,
                      child: Container(
                        width: 29,
                        height: 31,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.image_outlined,
                            size: 18,
                            color: Color(0xFF607696),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Color(0xFF18233A),
                        fontSize: 11,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Status: CONFIRMED • $status',
                      style: const TextStyle(
                        color: Color(0xFF607696),
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFF18233A),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 29,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111A2F),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.sync, size: 13),
                  label: const Text(
                    'Reorder',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

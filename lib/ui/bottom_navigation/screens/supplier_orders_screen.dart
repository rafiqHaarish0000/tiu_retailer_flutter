part of '../../dashboard/screens/dashboard_screen.dart';

class _SupplierOrdersPage extends StatefulWidget {
  const _SupplierOrdersPage({required this.onBack, required this.onPlaceOrder});

  final VoidCallback onBack;
  final VoidCallback onPlaceOrder;

  @override
  State<_SupplierOrdersPage> createState() => _SupplierOrdersPageState();
}

class _SupplierOrdersPageState extends State<_SupplierOrdersPage> {
  final ScrollController _productScrollController = ScrollController();
  Timer? _productAutoScrollTimer;

  @override
  void initState() {
    super.initState();
    _productAutoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_productScrollController.hasClients) return;

      final position = _productScrollController.position;
      final nextOffset = position.pixels >= position.maxScrollExtent - 8
          ? 0.0
          : (position.pixels + 174).clamp(0.0, position.maxScrollExtent);
      _productScrollController.animateTo(
        nextOffset,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _productAutoScrollTimer?.cancel();
    _productScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _squareButton(Icons.arrow_back, widget.onBack),
                  const SizedBox(width: 13),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Supplier Orders',
                        style: TextStyle(
                          color: Color(0xFF18233A),
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Wholesale Ordering Hub & Promotions',
                        style: TextStyle(
                          color: Color(0xFF607696),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 14, 15, 16),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFD7D7)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x121E3854),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE8E8),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Icon(
                            Icons.local_fire_department,
                            color: Color(0xFFE5252B),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 9),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bargain Bin Products',
                                style: TextStyle(
                                  color: Color(0xFF18233A),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Exclusive limited-time\npromotional deals',
                                style: TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD21E27),
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.bolt, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'HOT\nDEALS',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  height: 1,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 11),
                      child: Divider(color: Color(0xFFFFD9D9), height: 1),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 252,
                      child: ListView.separated(
                        controller: _productScrollController,
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.hardEdge,
                        itemCount: 3,
                        separatorBuilder: (_, _) => const SizedBox(width: 10),
                        itemBuilder: (context, index) =>
                            _ProductCard(index: index),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 13, 13, 13),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF0),
                  border: Border.all(color: const Color(0xFFFFD76B)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF1BD),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: const Icon(
                        Icons.lightbulb,
                        color: Color(0xFFE47700),
                        size: 21,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Fast Reorder Tip',
                                style: TextStyle(
                                  color: Color(0xFF633000),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(width: 7),
                              Text(
                                'Save Time',
                                style: TextStyle(
                                  color: Color(0xFFB96A00),
                                  fontSize: 10,
                                  backgroundColor: Color(0xFFFFE79A),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            'You can copy any previously delivered or\nconfirmed order directly into your cart with 1\nclick.',
                            style: TextStyle(
                              color: Color(0xFF9A4B00),
                              fontSize: 11,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFF28B00),
                      size: 21,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _SupplierActionCard(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Place Order',
                      subtitle: 'Browse partner suppliers',
                      onTap: widget.onPlaceOrder,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SupplierActionCard(
                      icon: Icons.history,
                      title: 'Order History',
                      subtitle: 'Track & reorder orders',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(right: 12, bottom: 14, child: _SupplierCartButton()),
      ],
    );
  }

  Widget _squareButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFDDE5EE)),
            boxShadow: const [
              BoxShadow(color: Color(0x121E3854), blurRadius: 4),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF20334F), size: 21),
        ),
      ),
    );
  }
}

class _SupplierCartButton extends StatelessWidget {
  const _SupplierCartButton();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFC81920), width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Color(0xFFC81920),
            size: 30,
          ),
        ),
        Positioned(
          right: -1,
          top: -8,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFFC81920),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text(
                '5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final isWater = index == 0;
    final title = isWater
        ? 'Bottled Water 500ml'
        : index == 1
        ? 'cane juice'
        : 'Bottled Water 1L';
    final price = isWater
        ? 'R15.00'
        : index == 1
        ? 'R9.00'
        : 'R85.00';
    return SizedBox(
      width: 164,
      child: Container(
        padding: const EdgeInsets.fromLTRB(9, 8, 9, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0xFFE5EAF1)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x101E3854),
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isWater
                        ? const Color(0xFFF33C45)
                        : const Color(0xFFFF9800),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    isWater ? '↓ 42%' : '▰ DEAL',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  '◷ 19d left',
                  style: TextStyle(color: Color(0xFF9A6500), fontSize: 9),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Container(
              height: 83,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FBFD),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: const Color(0xFFEAF0F5)),
              ),
              child: Center(
                child: Icon(
                  isWater
                      ? Icons.water_drop_outlined
                      : Icons.local_drink_outlined,
                  color: isWater
                      ? const Color(0xFF8CB6D8)
                      : const Color(0xFF71B75B),
                  size: 46,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 18,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              color: const Color(0xFFF0F3F7),
              child: Row(
                children: [
                  const Icon(Icons.store, color: Color(0xFFD7192F), size: 11),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      isWater ? 'test supplier' : 'Aishwarya Traders',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF455873),
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF18233A),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            const Text(
              '500 ml',
              style: TextStyle(color: Color(0xFF71839D), fontSize: 10),
            ),
            const SizedBox(height: 3),
            if (index == 0 || index == 2)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    index == 0 ? 'R25.66' : 'R785.05',
                    style: const TextStyle(
                      color: Color(0xFF9AA8B9),
                      fontSize: 11,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Color(0xFF9AA8B9),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Color(0xFFC81920),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              )
            else
              Text(
                price,
                style: const TextStyle(
                  color: Color(0xFFC81920),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            const SizedBox(height: 6),
            Container(
              height: 21,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFFF7D7D),
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                '🛒 Max 1 per order',
                style: TextStyle(
                  color: Color(0xFFC81920),
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
}

class _SupplierActionCard extends StatelessWidget {
  const _SupplierActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 131,
        padding: const EdgeInsets.all(12),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: const Color(0xFFE21E2A), size: 25),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF18233A),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(color: Color(0xFF71839D), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

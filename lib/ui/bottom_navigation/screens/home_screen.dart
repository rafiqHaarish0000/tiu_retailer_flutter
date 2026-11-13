part of '../../dashboard/screens/dashboard_screen.dart';

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({required this.services, required this.onServiceTap});

  final List<_Service> services;
  final ValueChanged<_Service> onServiceTap;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ServiceCard(
                service: services[index],
                onTap: () => onServiceTap(services[index]),
              ),
              childCount: services.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.92,
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service, required this.onTap});

  final _Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: service.disabled ? const Color(0xFFFBFBFB) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: service.disabled
            ? () => _showComingSoonToast(context, service.title)
            : onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 10),
          decoration: BoxDecoration(
            color: service.disabled ? const Color(0xFFFBFBFB) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: service.disabled
                  ? const Color(0xFFE8EAEC)
                  : const Color(0xFFDDE5EE),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A1E3854),
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: service.disabled
                            ? const Color(0xFFE8E8E8)
                            : service.iconBackground,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        service.icon,
                        color: service.disabled
                            ? const Color(0xFF929292)
                            : service.iconColor,
                        size: 25,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      service.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: service.disabled
                            ? const Color(0xFF969696)
                            : const Color(0xFF1E2A40),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      service.subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: service.disabled
                            ? const Color(0xFFB8B8B8)
                            : const Color(0xFF8498B6),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              if (service.disabled)
                Positioned(
                  top: -8,
                  right: -1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF858585),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'COMING SOON',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showComingSoonToast(BuildContext context, String productName) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text('$productName is coming soon in the next release!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
}

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _Service {
  const _Service(
    this.title,
    this.subtitle,
    this.icon,
    this.iconBackground,
    this.iconColor,
    this.screen, {
    this.disabled = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final Widget screen;
  final bool disabled;
}

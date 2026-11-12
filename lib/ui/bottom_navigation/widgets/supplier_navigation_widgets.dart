part of '../../dashboard/screens/dashboard_screen.dart';

Widget _backButton(VoidCallback onTap) => Material(
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
        boxShadow: const [BoxShadow(color: Color(0x121E3854), blurRadius: 4)],
      ),
      child: const Icon(Icons.arrow_back, color: Color(0xFF20334F), size: 21),
    ),
  ),
);

Widget _searchBox(String hint, {bool showButton = false}) => Container(
  height: 40,
  padding: const EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: const Color(0xFFDDE5EE)),
    boxShadow: const [BoxShadow(color: Color(0x101E3854), blurRadius: 5)],
  ),
  child: Row(
    children: [
      const Icon(Icons.search, color: Color(0xFF8FA2BA), size: 19),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          hint,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xFF8A9AB3), fontSize: 11),
        ),
      ),
      if (showButton)
        Container(
          width: 40,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFC81920),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.search, color: Colors.white, size: 17),
        ),
    ],
  ),
);

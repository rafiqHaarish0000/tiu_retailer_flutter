import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class WebsiteUsersScreen extends StatefulWidget {
  const WebsiteUsersScreen({this.onBack, super.key});
  final VoidCallback? onBack;
  @override
  State<WebsiteUsersScreen> createState() => _WebsiteUsersScreenState();
}

class _WebsiteUsersScreenState extends State<WebsiteUsersScreen> {
  final _users = <_WebUser>[
    _WebUser(
      'Zamier Seidel',
      'Zamier.Seidel.1110',
      'zamier.seidel@gmail.com',
      '18–10–2013 09:48 PM',
      '18–10–2026 08:30 PM',
    ),
    _WebUser(
      'Hassan Retailer',
      'hassen.Retailer.1110',
      'brindhasa@gmail.com',
      '20–06–2023 02:44 PM',
      '19–08–2026 08:57 PM',
    ),
    _WebUser(
      'Bindha Supplier',
      'Bindha.Supplier.1110',
      'bindha@gmail.com',
      '25–09–2023 12:06 PM',
      '-',
    ),
    _WebUser(
      'Swapna Priya',
      'Swapna.Priya.1110',
      'swapnaparwatha@gmail.com',
      '04–04–2024 01:26 PM',
      '12–04–2024 11:59 AM',
    ),
    _WebUser(
      'Manoj Kumar',
      'Manoj.Kumar.1110',
      'manojdevcg@gmail.com',
      '12–04–2024 03:12 PM',
      '-',
    ),
    _WebUser(
      'Brindha Baskaran',
      'Brindha.Retailer',
      'brindha.siet@gmail.com',
      '12–04–2023 12:27 PM',
      '16–11–2026 03:57 PM',
    ),
    _WebUser(
      'Rishana Neonx',
      'Rishana.Neonx.1110',
      'rishana@neonx.com',
      '14–11–2025 03:16 PM',
      '-',
    ),
    _WebUser(
      'RSH Neonx',
      'RSH.Neonx.1110',
      'rishana@example.com',
      '14–11–2025 03:16 PM',
      '-',
    ),
    _WebUser(
      'RSH Neo',
      'RSH.Neo.1110',
      'rishana@example.com',
      '14–11–2025 03:18 PM',
      '-',
    ),
    _WebUser(
      'Mary M',
      'Mary.M.1110',
      'mary@example.com',
      '14–11–2025 03:37 PM',
      '-',
    ),
  ];
  _WebUser? _editing;
  void _edit(_WebUser user) => setState(() => _editing = user);
  void _back() {
    if (_editing != null) {
      setState(() => _editing = null);
      return;
    }
    if (widget.onBack != null) widget.onBack!();
  }

  void _save(_WebUser value) {
    final i = _users.indexOf(_editing!);
    setState(() {
      if (i >= 0) _users[i] = value;
      _editing = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Website user saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: const Color(0xFFF5F8FC),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
          child: _Title(
            title: _editing == null ? 'Website Users' : 'Edit Website User',
            onTap: _back,
          ),
        ),
        Expanded(
          child: _editing == null
              ? _List(users: _users, onEdit: _edit, onBack: _back)
              : _Edit(user: _editing!, onCancel: _back, onSave: _save),
        ),
      ],
    ),
  );
}

class _Title extends StatelessWidget {
  const _Title({required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Container(
    height: 56,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(color: const Color(0xFFE5EBF1)),
    ),
    child: Row(
      children: [
        _BoxIcon(
          Icons.arrow_back,
          const Color(0xFFF0F6FA),
          const Color(0xFF28415C),
          onTap,
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF11182B),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        _BoxIcon(
          Icons.home_outlined,
          const Color(0xFFFFF0F2),
          AppColors.brandRed,
          onTap,
        ),
      ],
    ),
  );
}

class _BoxIcon extends StatelessWidget {
  const _BoxIcon(this.icon, this.bg, this.fg, this.onTap);
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

class _List extends StatelessWidget {
  const _List({
    required this.users,
    required this.onEdit,
    required this.onBack,
  });
  final List<_WebUser> users;
  final ValueChanged<_WebUser> onEdit;
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: const Color(0xFFE1E8F0)),
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
                        Icons.language,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'People who can login to this portal for your store',
                        style: TextStyle(
                          color: Color(0xFF7287A6),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              ...users.map((u) => _Row(user: u, onTap: () => onEdit(u))),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Page(text: '‹  Prev'),
            const Text(
              'Page 1 of 7 (64 records)',
              style: TextStyle(color: Color(0xFF7287A6), fontSize: 11),
            ),
            const _Page(text: 'Next  ›'),
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
            child: OutlinedButton(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFE9EFF6),
                foregroundColor: const Color(0xFF1E2A40),
                side: BorderSide.none,
              ),
              child: const Text('Back'),
            ),
          ),
        ),
      ],
    ),
  );
}

class _Page extends StatelessWidget {
  const _Page({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: null,
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFFEAF1F8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      minimumSize: Size.zero,
    ),
    child: Text(text),
  );
}

class _Row extends StatelessWidget {
  const _Row({required this.user, required this.onTap});
  final _WebUser user;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 11),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFEAF0F5))),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        color: Color(0xFF11182B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const _Active(),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '♙ ${user.username}',
                style: const TextStyle(color: Color(0xFF7287A6), fontSize: 11),
              ),
              const SizedBox(height: 3),
              Text(
                '✉ ${user.email}',
                style: const TextStyle(color: Color(0xFF7287A6), fontSize: 11),
              ),
              const SizedBox(height: 5),
              Text(
                'Created: ${user.created}  •  Last login: ${user.lastLogin}',
                style: const TextStyle(color: Color(0xFF8EA1BC), fontSize: 10),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        _BoxIcon(
          Icons.edit_outlined,
          const Color(0xFFF0F6FA),
          const Color(0xFF28415C),
          onTap,
        ),
      ],
    ),
  );
}

class _Active extends StatelessWidget {
  const _Active();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: const Color(0xFFE8FAF3),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Text(
      'Active',
      style: TextStyle(
        color: Color(0xFF00845A),
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

class _Edit extends StatefulWidget {
  const _Edit({
    required this.user,
    required this.onCancel,
    required this.onSave,
  });
  final _WebUser user;
  final VoidCallback onCancel;
  final ValueChanged<_WebUser> onSave;
  @override
  State<_Edit> createState() => _EditState();
}

class _EditState extends State<_Edit> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _name, _username, _email;
  bool _active = true;
  String _auth = 'Yes';
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.user.name.split(' ').first);
    _username = TextEditingController(text: widget.user.username);
    _email = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      v == null || v.trim().isEmpty ? 'This field is required' : null;
  String? _emailCheck(String? v) {
    final e = _required(v);
    if (e != null) return e;
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim())
        ? null
        : 'Enter a valid email';
  }

  void _submit() {
    if (_key.currentState!.validate()) {
      widget.onSave(
        _WebUser(
          _name.text.trim(),
          _username.text.trim(),
          _email.text.trim(),
          widget.user.created,
          widget.user.lastLogin,
          active: _active,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
    child: Form(
      key: _key,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: const Color(0xFFE1E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      Icons.language,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Update this website user and save',
                    style: TextStyle(color: Color(0xFF7287A6), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Input('NAME', _name, _required),
                  _Radio(
                    'STATUS',
                    const ['Active', 'Deactive'],
                    _active ? 'Active' : 'Deactive',
                    (v) => setState(() => _active = v == 'Active'),
                  ),
                  _Input('USER NAME', _username, _required),
                  _Input('EMAIL', _email, _emailCheck),
                  _Radio(
                    'AUTHORISATION',
                    const ['Yes', 'No'],
                    _auth,
                    (v) => setState(() => _auth = v),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFE9EFF6),
                      foregroundColor: const Color(0xFF1E2A40),
                      side: BorderSide.none,
                    ),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 12),
                  _GradientButton(onPressed: _submit),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Input extends StatelessWidget {
  const _Input(this.label, this.controller, this.validator);
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF344761),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            constraints: const BoxConstraints(minHeight: 46),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFC8D7E8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFC8D7E8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.brandRed,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.brandRed),
            ),
          ),
        ),
      ],
    ),
  );
}

class _Radio extends StatelessWidget {
  const _Radio(this.label, this.options, this.selected, this.onChanged);
  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF344761),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 12,
          children: options
              .map(
                (o) => InkWell(
                  onTap: () => onChanged(o),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Dot(selected: o == selected),
                      Text(
                        o,
                        style: const TextStyle(
                          color: Color(0xFF1E2A40),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

class _Dot extends StatelessWidget {
  const _Dot({required this.selected});
  final bool selected;
  @override
  Widget build(BuildContext context) => Container(
    width: 18,
    height: 18,
    margin: const EdgeInsets.only(right: 5),
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: selected ? AppColors.brandRed : const Color(0xFF6D7783),
      ),
    ),
    child: selected
        ? const DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.brandRed,
              shape: BoxShape.circle,
            ),
          )
        : null,
  );
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.brandRed, Color(0xFFE97900)],
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w700)),
    ),
  );
}

class _WebUser {
  _WebUser(
    this.name,
    this.username,
    this.email,
    this.created,
    this.lastLogin, {
    this.active = true,
  });
  String name;
  String username;
  String email;
  String created;
  String lastLogin;
  bool active;
}

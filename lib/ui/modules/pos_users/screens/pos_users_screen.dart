import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class PosUsersScreen extends StatefulWidget {
  const PosUsersScreen({this.onBack, super.key});
  final VoidCallback? onBack;
  @override
  State<PosUsersScreen> createState() => _PosUsersScreenState();
}

class _PosUsersScreenState extends State<PosUsersScreen> {
  final _users = <_PosUser>[
    const _PosUser(
      'SYSTEM',
      '',
      '',
      '1425',
      'Admin',
      true,
      true,
      'Administrator',
    ),
    const _PosUser(
      'Zamier Seidel',
      '',
      '',
      '',
      'Admin',
      false,
      true,
      'Administrator',
    ),
    const _PosUser(
      'Khalied Parker',
      '',
      '',
      '',
      'Admin',
      false,
      true,
      'Administrator',
    ),
    const _PosUser(
      'Hobart Jeremiah',
      '',
      '',
      '',
      'Cashier',
      false,
      true,
      'Cashier',
    ),
    const _PosUser(
      'Samsonite Chongo',
      '',
      '',
      '',
      'Cashier',
      false,
      true,
      'Cashier',
    ),
    const _PosUser(
      'Abongile Xhasant',
      '',
      '',
      '',
      'Cashier',
      false,
      true,
      'Cashier',
    ),
    const _PosUser('Jaj Gja', '', '', '', 'Cashier', false, true, 'Cashier'),
    const _PosUser(
      'Malika Abrahams',
      '',
      '',
      '',
      'Cashier',
      false,
      true,
      'Cashier',
    ),
    const _PosUser('Aadm Djm', '', '', '', 'Cashier', false, true, 'Cashier'),
    const _PosUser(
      'Yacoob Folnker',
      '',
      '',
      '',
      'Admin',
      false,
      true,
      'Administrator',
    ),
  ];
  _PosUser? _editing;
  bool _adding = false;

  void _openAdd() => setState(() {
    _adding = true;
    _editing = null;
  });
  void _openEdit(_PosUser user) => setState(() {
    _adding = false;
    _editing = user;
  });
  void _closeForm() => setState(() {
    _adding = false;
    _editing = null;
  });
  void _goBack() {
    if (_adding || _editing != null) {
      _closeForm();
      return;
    }
    if (widget.onBack != null) {
      widget.onBack!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _saveUser(_PosUser user) {
    final index = _editing == null ? -1 : _users.indexOf(_editing!);
    setState(() {
      if (index >= 0) {
        _users[index] = user;
      } else {
        _users.insert(0, user);
      }
      _adding = false;
      _editing = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('POS user saved successfully')),
    );
  }

  Future<void> _deleteUser(_PosUser user) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete POS User?'),
            content: Text('Remove ${user.displayName} from this account?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed || !mounted) return;
    setState(() => _users.remove(user));
  }

  @override
  Widget build(BuildContext context) {
    final form = _adding || _editing != null;
    return ColoredBox(
      color: const Color(0xFFF5F8FC),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
            child: _TitleBar(
              title: form
                  ? (_adding ? 'Add POS User' : 'Edit POS User')
                  : 'POS Users',
              onBack: _goBack,
            ),
          ),
          Expanded(
            child: form
                ? _UserForm(
                    user: _editing,
                    onCancel: _closeForm,
                    onSave: _saveUser,
                  )
                : _UserList(
                    users: _users,
                    onEdit: _openEdit,
                    onDelete: _deleteUser,
                    onAdd: _openAdd,
                    onBack: _goBack,
                  ),
          ),
        ],
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.title, required this.onBack});
  final String title;
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
        _IconButton(
          icon: Icons.arrow_back,
          background: const Color(0xFFF0F6FA),
          color: const Color(0xFF28415C),
          onTap: onBack,
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF11182B),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        _IconButton(
          icon: Icons.home_outlined,
          background: const Color(0xFFFFF0F2),
          color: AppColors.brandRed,
          onTap: onBack,
        ),
      ],
    ),
  );
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.background,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final Color background;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: background,
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, color: color, size: 21),
      ),
    ),
  );
}

class _UserList extends StatelessWidget {
  const _UserList({
    required this.users,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
    required this.onBack,
  });
  final List<_PosUser> users;
  final ValueChanged<_PosUser> onEdit;
  final ValueChanged<_PosUser> onDelete;
  final VoidCallback onAdd;
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(4, 0, 4, 24),
    child: Column(
      children: [
        Container(
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
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Cashiers and administrators who can use your\nPOS devices',
                        style: TextStyle(
                          color: Color(0xFF7287A6),
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              ...users.map(
                (user) => _UserRow(
                  user: user,
                  onEdit: () => onEdit(user),
                  onDelete: () => onDelete(user),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PageButton(label: '‹  Prev', enabled: false, onTap: () {}),
            const Text(
              'Page 1 of 8 (75 records)',
              style: TextStyle(color: Color(0xFF7287A6), fontSize: 11),
            ),
            _PageButton(label: 'Next  ›', enabled: true, onTap: () {}),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: const Color(0xFFE1E8F0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFE9EFF6),
                  foregroundColor: const Color(0xFF1E2A40),
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 11,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Back'),
              ),
              const SizedBox(width: 12),
              _GradientButton(
                label: '+  Add New',
                onPressed: onAdd,
                horizontalPadding: 18,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.label,
    required this.enabled,
    required this.onTap,
  });
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: enabled ? onTap : null,
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFFEAF1F8),
      foregroundColor: const Color(0xFF7287A6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.onPressed,
    required this.horizontalPadding,
  });
  final String label;
  final VoidCallback onPressed;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [AppColors.brandRed, Color(0xFFE97900)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x2FC8102E),
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 11,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    ),
  );
}

class _UserRow extends StatelessWidget {
  const _UserRow({
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });
  final _PosUser user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(16, 11, 16, 11),
    decoration: const BoxDecoration(
      border: Border(top: BorderSide(color: Color(0xFFEAF0F5))),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.displayName,
                style: const TextStyle(
                  color: Color(0xFF11182B),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  _StatusChip(label: user.role, role: true),
                  const SizedBox(width: 8),
                  _StatusChip(
                    label: user.active ? 'Active' : 'Deactive',
                    role: false,
                  ),
                ],
              ),
            ],
          ),
        ),
        _SmallAction(
          icon: Icons.edit_outlined,
          color: const Color(0xFF28415C),
          background: const Color(0xFFF0F6FA),
          onTap: onEdit,
        ),
        const SizedBox(width: 8),
        _SmallAction(
          icon: Icons.delete_outline,
          color: AppColors.brandRed,
          background: const Color(0xFFFFF0F2),
          onTap: onDelete,
        ),
      ],
    ),
  );
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.role});
  final String label;
  final bool role;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: role
          ? (label == 'Admin'
                ? const Color(0xFFEFF0FF)
                : const Color(0xFFF0F4F7))
          : (label == 'Active'
                ? const Color(0xFFE8FAF3)
                : const Color(0xFFFFEEF0)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: role
            ? (label == 'Admin'
                  ? const Color(0xFF2924DE)
                  : const Color(0xFF31445A))
            : (label == 'Active'
                  ? const Color(0xFF00845A)
                  : AppColors.brandRed),
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class _SmallAction extends StatelessWidget {
  const _SmallAction({
    required this.icon,
    required this.color,
    required this.background,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: background,
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, color: color, size: 19),
      ),
    ),
  );
}

class _UserForm extends StatefulWidget {
  const _UserForm({
    required this.user,
    required this.onCancel,
    required this.onSave,
  });
  final _PosUser? user;
  final VoidCallback onCancel;
  final ValueChanged<_PosUser> onSave;
  @override
  State<_UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<_UserForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _first;
  late final TextEditingController _surname;
  late final TextEditingController _id;
  late final TextEditingController _pin;
  bool _swipe = false;
  bool _active = true;
  String _authorization = 'Administrator';
  @override
  void initState() {
    super.initState();
    final user = widget.user;
    _first = TextEditingController(text: user?.firstName);
    _surname = TextEditingController(text: user?.surname);
    _id = TextEditingController(text: user?.idNumber);
    _pin = TextEditingController(text: user?.pin);
    _swipe = user?.swipeEnabled ?? false;
    _active = user?.active ?? true;
    _authorization = user?.authorization ?? 'Administrator';
  }

  @override
  void dispose() {
    _first.dispose();
    _surname.dispose();
    _id.dispose();
    _pin.dispose();
    super.dispose();
  }

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'This field is required' : null;
  String? _pinValidator(String? value) {
    final required = _required(value);
    if (required != null) return required;
    return RegExp(r'^\d{4}$').hasMatch(value!.trim())
        ? null
        : 'PIN must be exactly 4 digits';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSave(
      _PosUser(
        _first.text.trim(),
        _surname.text.trim(),
        _id.text.trim(),
        _pin.text.trim(),
        _authorization == 'Administrator' ? 'Admin' : 'Cashier',
        _active,
        _swipe,
        _authorization,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
    child: Form(
      key: _formKey,
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.brandRed, Color(0xFFE97900)],
                      ),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.user == null
                        ? 'Fill in the details and save'
                        : 'Update this POS user and save',
                    style: const TextStyle(
                      color: Color(0xFF7287A6),
                      fontSize: 12,
                    ),
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
                  _Input(
                    label: 'FIRST NAME',
                    controller: _first,
                    validator: _required,
                  ),
                  _Input(
                    label: 'SURNAME',
                    controller: _surname,
                    validator: _required,
                  ),
                  _Input(
                    label: 'ID NUMBER',
                    controller: _id,
                    validator: _required,
                  ),
                  _Input(
                    label: 'PIN NUMBER',
                    controller: _pin,
                    validator: _pinValidator,
                    obscure: true,
                  ),
                  _RadioGroup(
                    label: 'SWIPE CARD ENABLED',
                    options: const ['Yes', 'No'],
                    selected: _swipe ? 'Yes' : 'No',
                    onChanged: (value) =>
                        setState(() => _swipe = value == 'Yes'),
                  ),
                  _RadioGroup(
                    label: 'STATUS',
                    options: const ['Active', 'Suspended'],
                    selected: _active ? 'Active' : 'Suspended',
                    onChanged: (value) =>
                        setState(() => _active = value == 'Active'),
                  ),
                  _RadioGroup(
                    label: 'AUTHORISATION',
                    options: const ['Administrator', 'Cashier'],
                    selected: _authorization,
                    onChanged: (value) =>
                        setState(() => _authorization = value),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 14, 13, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFE9EFF6),
                      foregroundColor: const Color(0xFF1E2A40),
                      side: BorderSide.none,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 11,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 12),
                  _GradientButton(
                    label: 'Save',
                    onPressed: _submit,
                    horizontalPadding: 24,
                  ),
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
  const _Input({
    required this.label,
    required this.controller,
    required this.validator,
    this.obscure = false,
  });
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final bool obscure;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
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
          obscureText: obscure,
          keyboardType: label == 'PIN NUMBER'
              ? TextInputType.number
              : TextInputType.text,
          style: const TextStyle(color: Color(0xFF2C3A51), fontSize: 14),
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

class _RadioGroup extends StatelessWidget {
  const _RadioGroup({
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
  });
  final String label;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
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
                (option) => InkWell(
                  onTap: () => onChanged(option),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _RadioDot(selected: option == selected),
                      Text(
                        option,
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

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});
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
        width: 1,
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

class _PosUser {
  const _PosUser(
    this.firstName,
    this.surname,
    this.idNumber,
    this.pin,
    this.role,
    this.active,
    this.swipeEnabled,
    this.authorization,
  );
  final String firstName;
  final String surname;
  final String idNumber;
  final String pin;
  final String role;
  final bool active;
  final bool swipeEnabled;
  final String authorization;
  String get displayName => surname.isEmpty ? firstName : '$firstName $surname';
}

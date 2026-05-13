import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';
  String _selectedTheme = 'Light';

  final List<Map<String, dynamic>> _settingsItems = [];

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.person_outline,
        'color': const Color(0xFFDBEAFF),
        'iconColor': const Color(0xFF3B82F6),
        'title': 'Personal Information',
        'subtitle': null,
        'onTap': () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const EditProfileScreen())),
      },
      {
        'icon': Icons.notifications_none,
        'color': const Color(0xFFFFE4E6),
        'iconColor': const Color(0xFFEF4444),
        'title': 'Notification Preferences',
        'subtitle': null,
        'onTap': () => _showNotifPrefs(context),
      },
      {
        'icon': Icons.lock_outline,
        'color': const Color(0xFFD0F0EC),
        'iconColor': const Color(0xFF4A9B8E),
        'title': 'Security & Passcode',
        'subtitle': null,
        'onTap': () => _showSecurityDialog(context),
      },
      {
        'icon': Icons.language,
        'color': const Color(0xFFDBEAFF),
        'iconColor': const Color(0xFF6366F1),
        'title': 'Language',
        'subtitle': _selectedLanguage,
        'onTap': () => _showLanguagePicker(context),
      },
      {
        'icon': Icons.wb_sunny_outlined,
        'color': const Color(0xFFFFF3D0),
        'iconColor': const Color(0xFFF59E0B),
        'title': 'App Theme',
        'subtitle': _selectedTheme,
        'onTap': () => _showThemePicker(context),
      },
      {
        'icon': Icons.settings_outlined,
        'color': const Color(0xFFEDE9FE),
        'iconColor': const Color(0xFF8B5CF6),
        'title': 'System Permissions',
        'subtitle': 'Camera, Location, Notifications, etc.',
        'onTap': () => _showPermissionsDialog(context),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildUserRow(context),
                    const SizedBox(height: 24),
                    const Text(
                      'Settings & Preferences',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...items.map((item) => _buildSettingTile(
                          icon: item['icon'] as IconData,
                          bgColor: item['color'] as Color,
                          iconColor: item['iconColor'] as Color,
                          title: item['title'] as String,
                          subtitle: item['subtitle'] as String?,
                          onTap: item['onTap'] as VoidCallback,
                        )),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text('Settings',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E))),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildUserRow(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFFE0B2),
          ),
          child: const Icon(Icons.person, size: 30, color: Color(0xFF4A9B8E)),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rahul Sharma',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 2),
            Text('User ID',
                style: TextStyle(fontSize: 13, color: Colors.grey[500])),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: subtitle != null && title.contains(':')
                              ? '${title.split(':')[0]}: '
                              : title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        if (subtitle != null &&
                            (title == 'Language' || title == 'App Theme'))
                          TextSpan(
                            text: subtitle,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (subtitle != null &&
                      title != 'Language' &&
                      title != 'App Theme')
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(subtitle,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF9CA3AF))),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomIcon(Icons.medical_kit_outlined, const Color(0xFFDBEAFF)),
          _bottomIcon(Icons.location_on_outlined, const Color(0xFFDBEAFF)),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF4A9B8E),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
          _bottomIcon(Icons.flight_outlined, const Color(0xFFFFE4E6)),
          _bottomIcon(Icons.business_center_outlined, const Color(0xFFFFF3D0)),
        ],
      ),
    );
  }

  Widget _bottomIcon(IconData icon, Color bg) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bg),
      child: Icon(icon, size: 20, color: const Color(0xFF6B7280)),
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _LanguagePicker(
        selected: _selectedLanguage,
        onSelect: (lang) => setState(() => _selectedLanguage = lang),
      ),
    );
  }

  void _showThemePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _ThemePicker(
        selected: _selectedTheme,
        onSelect: (t) => setState(() => _selectedTheme = t),
      ),
    );
  }

  void _showNotifPrefs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const _NotifPrefsSheet(),
    );
  }

  void _showSecurityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Security & Passcode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dialogOption(Icons.fingerprint, 'Biometric Login'),
            _dialogOption(Icons.pin_outlined, 'Change Passcode'),
            _dialogOption(Icons.lock_reset, 'Reset PIN'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: Color(0xFF4A9B8E)))),
        ],
      ),
    );
  }

  void _showPermissionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('System Permissions'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _permissionRow('Camera', true),
            _permissionRow('Location', true),
            _permissionRow('Notifications', false),
            _permissionRow('Storage', true),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done', style: TextStyle(color: Color(0xFF4A9B8E)))),
        ],
      ),
    );
  }

  Widget _dialogOption(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4A9B8E)),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: () {},
    );
  }

  Widget _permissionRow(String label, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Switch(
            value: enabled,
            onChanged: (_) {},
            activeColor: const Color(0xFF4A9B8E),
          ),
        ],
      ),
    );
  }
}

// --- Bottom Sheet Widgets ---

class _LanguagePicker extends StatelessWidget {
  final String selected;
  final Function(String) onSelect;
  const _LanguagePicker({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final langs = ['English', 'Hindi', 'Gujarati', 'Marathi', 'Tamil', 'Telugu'];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Language',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...langs.map((l) => ListTile(
                title: Text(l),
                trailing: selected == l
                    ? const Icon(Icons.check_circle, color: Color(0xFF4A9B8E))
                    : null,
                onTap: () {
                  onSelect(l);
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}

class _ThemePicker extends StatelessWidget {
  final String selected;
  final Function(String) onSelect;
  const _ThemePicker({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final themes = ['Light', 'Dark', 'System Default'];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...themes.map((t) => ListTile(
                leading: Icon(
                  t == 'Light' ? Icons.wb_sunny : t == 'Dark' ? Icons.nightlight : Icons.settings_brightness,
                  color: const Color(0xFF4A9B8E),
                ),
                title: Text(t),
                trailing: selected == t
                    ? const Icon(Icons.check_circle, color: Color(0xFF4A9B8E))
                    : null,
                onTap: () {
                  onSelect(t);
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}

class _NotifPrefsSheet extends StatefulWidget {
  const _NotifPrefsSheet();

  @override
  State<_NotifPrefsSheet> createState() => _NotifPrefsSheetState();
}

class _NotifPrefsSheetState extends State<_NotifPrefsSheet> {
  bool _emi = true, _offers = false, _updates = true, _security = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Notification Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _notifRow('EMI Reminders', _emi, (v) => setState(() => _emi = v)),
          _notifRow('Loan Offers', _offers, (v) => setState(() => _offers = v)),
          _notifRow('App Updates', _updates, (v) => setState(() => _updates = v)),
          _notifRow('Security Alerts', _security, (v) => setState(() => _security = v)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notification preferences saved!'),
                    backgroundColor: Color(0xFF4A9B8E),
                  ),
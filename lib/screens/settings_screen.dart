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

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.person_outline,
        'color': const Color(0xFFDBEAFF),
        'iconColor': const Color(0xFF3B82F6),
        'title': 'Personal Information',
        'subtitle': null,
        'onTap': () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const EditProfileScreen())),
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
                    _buildUserRow(),
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
                    ...items.map(
                      (item) => _buildSettingTile(
                        icon: item['icon'] as IconData,
                        bgColor: item['color'] as Color,
                        iconColor: item['iconColor'] as Color,
                        title: item['title'] as String,
                        subtitle: item['subtitle'] as String?,
                        onTap: item['onTap'] as VoidCallba
import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'my_loans_screen.dart';
import 'loan_calculator_screen.dart';
import 'manage_bank_screen.dart';
import 'notifications_screen.dart';
import 'support_screen.dart';
import 'about_screen.dart';
import 'invite_screen.dart';
import 'profile_screen.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onClose;
  const AppDrawer({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.home_outlined, 'label': 'Home', 'active': true, 'screen': null},
      {'icon': Icons.account_balance_wallet_outlined, 'label': 'My Loans & Payments', 'active': false, 'screen': 'loans'},
      {'icon': Icons.calculate_outlined, 'label': 'Loan Calculator', 'active': false, 'screen': 'calc'},
      {'icon': Icons.settings_outlined, 'label': 'Settings & Preferences', 'active': false, 'screen': 'settings'},
      {'icon': Icons.credit_card_outlined, 'label': 'Manage Bank Accounts', 'active': false, 'screen': 'bank'},
      {'icon': Icons.notifications_none, 'label': 'Notifications', 'active': false, 'screen': 'notif'},
      {'icon': Icons.headset_mic_outlined, 'label': 'Support & Help', 'active': false, 'screen': 'support'},
      {'icon': Icons.info_outline, 'label': 'About EasyLoan', 'active': false, 'screen': 'about'},
      {'icon': Icons.share_outlined, 'label': 'Invite Friends\n(Refer & Earn)', 'active': false, 'screen': 'invite'},
    ];

    return GestureDetector(
      onTap: onClose,
      child: Stack(
        children: [
          Container(color: Colors.black.withOpacity(0.35)),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width * 0.78,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close, size: 22),
                            onPressed: onClose,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                      child: GestureDetector(
                        onTap: () {
                          onClose();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const ProfileScreen()));
                        },
                        child: Row(
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
                                Text('View Profile',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.teal[400])),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          final isActive = item['active'] as bool;
                          return GestureDetector(
                            onTap: () {
                              onClose();
                              _navigate(context, item['screen'] as String?);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 13),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color(0xFFF0F8F5)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item['icon'] as IconData,
                                    size: 22,
                                    color: isActive
                                        ? const Color(0xFF4A9B8E)
                                        : const Color(0xFF4B5563),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Text(
                                      item['label'] as String,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: isActive
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isActive
                                            ? const Color(0xFF1A1A2E)
                                            : const Color(0xFF4B5563),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    GestureDetector(
                      onTap: () => _showLogout(context),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(26, 16, 20, 20),
                        child: Row(
                          children: [
                            Icon(Icons.logout, size: 22, color: Color(0xFFEF4444)),
                            SizedBox(width: 14),
                            Text('Logout',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFEF4444),
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, String? screen) {
    if (screen == null) return;
    final routes = {
      'loans': () => const MyLoansScreen(),
      'calc': () => const LoanCalculatorScreen(),
      'settings': () => const SettingsScreen(),
      'bank': () => const ManageBankScreen(),
      'notif': () => const NotificationsScreen(),
      'support': () => const SupportScreen(),
      'about': () => const AboutScreen(),
      'invite': () => const InviteScreen(),
    };
    final builder = routes[screen];
    if (builder != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => builder()));
    }
  }

  void _showLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF6B7280))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onClose();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Color(0xFF4A9B8E),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
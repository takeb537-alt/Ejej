import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifs = [
    {'icon': Icons.payments_outlined, 'color': Color(0xFFD0F0EC), 'title': 'EMI Due Reminder', 'body': 'Your EMI of ₹88.96 is due on 15 Jun 2025.', 'time': '2 hours ago', 'read': false},
    {'icon': Icons.check_circle_outline, 'color': Color(0xFFDBEAFF), 'title': 'Loan Approved!', 'body': 'Your loan application for ₹1000 has been approved.', 'time': '1 day ago', 'read': false},
    {'icon': Icons.local_offer_outlined, 'color': Color(0xFFFFF3D0), 'title': 'Special Offer', 'body': 'Get personal loan at 6.5% p.a. - Limited time!', 'time': '3 days ago', 'read': true},
    {'icon': Icons.security_outlined, 'color': Color(0xFFFFE4E6), 'title': 'Login Alert', 'body': 'New login detected from Delhi, India.', 'time': '5 days ago', 'read': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        actions: [
          TextButton(
            onPressed: () => setState(() {
              for (var n in _notifs) n['read'] = true;
            }),
            child: const Text('Mark all read', style: TextStyle(color: Color(0xFF4A9B8E), fontSize: 12)),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _notifs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final n = _notifs[i];
          return GestureDetector(
            onTap: () => setState(() => n['read'] = true),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: (n['read'] as bool) ? Colors.white : const Color(0xFFF0F8F5),
                borderRadius: BorderRadius.circular(14),
                border: (n['read'] as bool) ? null : Border.all(color: const Color(0xFFB2E8E2), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: n['color'] as Color, shape: BoxShape.circle),
                    child: Icon(n['icon'] as IconData, size: 20, color: const Color(0xFF4A9B8E)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(n['title'] as String,
                                style: TextStyle(
                                    fontWeight: (n['read'] as bool) ? FontWeight.normal : FontWeight.bold,
                                    fontSize: 14, color: const Color(0xFF1A1A2E))),
                            if (!(n['read'] as bool))
                              Container(
                                width: 8, height: 8,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF4A9B8E)),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(n['body'] as String,
                            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                        const SizedBox(height: 4),
                        Text(n['time'] as String,
                            style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
        title: const Text('About EasyLoan',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(color: const Color(0xFFD0F0EC), borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.account_balance, size: 40, color: Color(0xFF4A9B8E)),
                ),
                const SizedBox(height: 12),
                const Text('EasyLoan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
                const Text('Version 1.0.0', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                const SizedBox(height: 8),
                const Text('Your Categories, Your Amount.', style: TextStyle(color: Color(0xFF4A9B8E), fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _infoCard('Our Mission', 'EasyLoan empowers individuals with quick, transparent, and affordable personal loans. We believe everyone deserves access to financial support when they need it most.'),
          const SizedBox(height: 12),
          _infoCard('Why EasyLoan?', '• 100% paperless process\n• Instant approval in minutes\n• Flexible loan amounts\n• Transparent interest rates\n• Secure & RBI compliant'),
          const SizedBox(height: 12),
          _linksCard(context),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF1A1A2E))),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.6)),
        ],
      ),
    );
  }

  Widget _linksCard(BuildContext context) {
    final links = ['Privacy Policy', 'Terms & Conditions', 'Rate Us ⭐', 'Contact Support'];
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: links.map((l) => ListTile(
          title: Text(l, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.chevron_right, size: 18, color: Color(0xFF9CA3AF)),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$l coming soon!'), backgroundColor: const Color(0xFF4A9B8E)),
          ),
        )).toList(),
      ),
    );
  }
}
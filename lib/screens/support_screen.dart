import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {'q': 'How to apply for a loan?', 'a': 'Go to Home, choose your loan amount and category, then tap Get Started and follow the steps.'},
      {'q': 'When will my loan be disbursed?', 'a': 'After approval, funds are transferred to your bank within 2-4 hours.'},
      {'q': 'How to pay EMI?', 'a': 'Go to My Loans & Payments and tap Pay EMI Now for your active loan.'},
      {'q': 'How to change my bank account?', 'a': 'Go to Drawer → Manage Bank Accounts and add or update your bank.'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Support & Help',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _contactCard(context),
          const SizedBox(height: 20),
          const Text('FAQs', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
          const SizedBox(height: 12),
          ...faqs.map((faq) => _faqTile(faq['q']!, faq['a']!)),
        ],
      ),
    );
  }

  Widget _contactCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF4A9B8E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Contact Us', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              _contactBtn(context, Icons.chat_outlined, 'Live Chat'),
              const SizedBox(width: 12),
              _contactBtn(context, Icons.email_outlined, 'Email Us'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactBtn(BuildContext context, IconData icon, String label) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label feature coming soon!'), backgroundColor: const Color(0xFF4A9B8E)),
        ),
        icon: Icon(icon, size: 16),
        label: Text(label, style: const TextStyle(fontSize: 13)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF4A9B8E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _faqTile(String q, String a) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        title: Text(q, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
        iconColor: const Color(0xFF4A9B8E),
        collapsedIconColor: const Color(0xFF9CA3AF),
        children: [
          Text(a, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.5)),
        ],
      ),
    );
  }
}
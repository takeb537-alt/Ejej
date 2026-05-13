import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key});

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
        title: const Text('Invite Friends',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _heroBanner(),
            const SizedBox(height: 20),
            _referralCode(context),
            const SizedBox(height: 20),
            _howItWorks(),
            const SizedBox(height: 20),
            _shareButton(context),
          ],
        ),
      ),
    );
  }

  Widget _heroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF4A9B8E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.card_giftcard, size: 52, color: Colors.white),
          SizedBox(height: 12),
          Text('Earn ₹50 per Referral!',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text('Invite friends & earn when they take their first loan.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _referralCode(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Referral Code',
              style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD0F0EC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('RAHUL50',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E), letterSpacing: 4)),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: 'RAHUL50'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Referral code copied! ✅'), backgroundColor: Color(0xFF4A9B8E)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A9B8E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.copy, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _howItWorks() {
    final steps = [
      {'icon': Icons.share_outlined, 'title': 'Share Code', 'sub': 'Share your referral code with friends'},
      {'icon': Icons.person_add_outlined, 'title': 'Friend Joins', 'sub': 'They sign up using your code'},
      {'icon': Icons.currency_rupee, 'title': 'You Earn', 'sub': '₹50 credited to your account'},
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('How it Works', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: steps.asMap().entries.map((e) {
              final colors = [Color(0xFFDBEAFF), Color(0xFFD0F0EC), Color(0xFFFFF3D0)];
              return Column(
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(color: colors[e.key], shape: BoxShape.circle),
                    child: Icon(e.value['icon'] as IconData, color: const Color(0xFF4A9B8E), size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(e.value['title'] as String,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  SizedBox(
                    width: 90,
                    child: Text(e.value['sub'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _shareButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Share feature coming soon! 🔗'), backgroundColor: Color(0xFF4A9B8E)),
        ),
        icon: const Icon(Icons.share, color: Colors.white),
        label: const Text('Share with Friends', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A9B8E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 0,
        ),
      ),
    );
  }
}
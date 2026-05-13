import 'package:flutter/material.dart';

class ManageBankScreen extends StatefulWidget {
  const ManageBankScreen({super.key});
  @override
  State<ManageBankScreen> createState() => _ManageBankScreenState();
}

class _ManageBankScreenState extends State<ManageBankScreen> {
  final List<Map<String, dynamic>> _banks = [
    {'name': 'SBI', 'account': 'XXXX XXXX 4521', 'primary': true, 'color': Color(0xFFD0F0EC)},
    {'name': 'HDFC Bank', 'account': 'XXXX XXXX 8832', 'primary': false, 'color': Color(0xFFDBEAFF)},
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
        title: const Text('Manage Bank Accounts',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF4A9B8E)),
            onPressed: () => _showAddBank(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ..._banks.map((bank) => _bankCard(bank)),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _showAddBank(context),
            icon: const Icon(Icons.add, color: Color(0xFF4A9B8E)),
            label: const Text('Add New Bank Account', style: TextStyle(color: Color(0xFF4A9B8E))),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF4A9B8E)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bankCard(Map<String, dynamic> bank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: (bank['primary'] as bool)
            ? Border.all(color: const Color(0xFF4A9B8E), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: bank['color'] as Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.account_balance, color: Color(0xFF4A9B8E), size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bank['name'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(bank['account'] as String,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              ],
            ),
          ),
          if (bank['primary'] as bool)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFD0F0EC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Primary',
                  style: TextStyle(fontSize: 11, color: Color(0xFF4A9B8E), fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  void _showAddBank(BuildContext context) {
    final ifscCtrl = TextEditingController();
    final accCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20, right: 20, top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Bank Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: accCtrl,
              keyboardType: TextInputType.number,
              decoration: _inputDecor('Account Number', Icons.credit_card_outlined),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ifscCtrl,
              decoration: _inputDecor('IFSC Code', Icons.code),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _banks.add({
                      'name': 'New Bank',
                      'account': 'XXXX XXXX ${accCtrl.text.isNotEmpty ? accCtrl.text.substring(max(0, accCtrl.text.length - 4)) : "0000"}',
                      'primary': false,
                      'color': const Color(0xFFFFF3D0),
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bank account added! ✅'), backgroundColor: Color(0xFF4A9B8E)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A9B8E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text('Add Account', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecor(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF4A9B8E), size: 20),
        filled: true,
        fillColor: const Color(0xFFF5F6FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF4A9B8E))),
      );
}

int max(int a, int b) => a > b ? a : b;
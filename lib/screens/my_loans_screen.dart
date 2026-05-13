import 'package:flutter/material.dart';

class MyLoansScreen extends StatefulWidget {
  const MyLoansScreen({super.key});
  @override
  State<MyLoansScreen> createState() => _MyLoansScreenState();
}

class _MyLoansScreenState extends State<MyLoansScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  final _activeLoans = [
    {'amount': '₹1000', 'type': 'Personal Loan', 'emi': '₹88.96', 'due': '15 Jun 2025', 'paid': 4, 'total': 12, 'color': Color(0xFFD0F0EC)},
    {'amount': '₹500', 'type': 'Education Loan', 'emi': '₹44.48', 'due': '20 Jun 2025', 'paid': 2, 'total': 12, 'color': Color(0xFFDBEAFF)},
  ];

  final _paidLoans = [
    {'amount': '₹200', 'type': 'Travel Loan', 'closedOn': 'Mar 2024', 'color': Color(0xFFFFF3D0)},
    {'amount': '₹100', 'type': 'Personal Loan', 'closedOn': 'Jan 2024', 'color': Color(0xFFFFE4E6)},
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
        title: const Text('My Loans & Payments',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        bottom: TabBar(
          controller: _tab,
          labelColor: const Color(0xFF4A9B8E),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: const Color(0xFF4A9B8E),
          tabs: const [Tab(text: 'Active Loans'), Tab(text: 'Paid Off')],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _buildActiveLoans(),
          _buildPaidLoans(),
        ],
      ),
    );
  }

  Widget _buildActiveLoans() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _summaryCard(),
        const SizedBox(height: 16),
        ..._activeLoans.map(_activeLoanCard),
      ],
    );
  }

  Widget _summaryCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF4A9B8E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(label: 'Total Loans', value: '2'),
          _SummaryItem(label: 'Total Due', value: '₹1,500'),
          _SummaryItem(label: 'Next EMI', value: '15 Jun'),
        ],
      ),
    );
  }

  Widget _activeLoanCard(Map<String, dynamic> loan) {
    final progress = (loan['paid'] as int) / (loan['total'] as int);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: loan['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(loan['type'] as String,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              Text(loan['amount'] as String,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EMI: ${loan['emi']}',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
              Text('Due: ${loan['due']}',
                  style: const TextStyle(fontSize: 13, color: Color(0xFFEF4444))),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE5E7EB),
            color: const Color(0xFF4A9B8E),
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
          const SizedBox(height: 4),
          Text('${loan['paid']}/${loan['total']} EMIs paid',
              style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('EMI Payment initiated! ✅'),
                    backgroundColor: Color(0xFF4A9B8E),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A9B8E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: const Text('Pay EMI Now', style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaidLoans() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _paidLoans
          .map((loan) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: loan['color'] as Color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.check_circle_outline,
                          color: Color(0xFF4A9B8E), size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(loan['type'] as String,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          Text('Closed: ${loan['closedOn']}',
                              style: const TextStyle(
                                  fontSize: 12, color: Color(0xFF9CA3AF))),
                        ],
                      ),
                    ),
                    Text(loan['amount'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF4A9B8E))),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label, value;
  const _SummaryItem({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
      ],
    );
  }
}
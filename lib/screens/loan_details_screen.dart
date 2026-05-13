import 'package:flutter/material.dart';

class LoanDetailsScreen extends StatefulWidget {
  final String amount;
  final Color color;
  final String? category;

  const LoanDetailsScreen({
    super.key,
    required this.amount,
    required this.color,
    this.category,
  });

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  bool _agreed = true;

  double get _principal {
    final cleaned = widget.amount.replaceAll('₹', '').replaceAll(',', '');
    return double.tryParse(cleaned) ?? 100;
  }

  double get _interestRate => 7.5;
  int get _tenureMonths => 12;
  double get _totalPayable => _principal * (1 + (_interestRate / 100));
  double get _emi => _totalPayable / _tenureMonths;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAmountCard(),
                    const SizedBox(height: 20),
                    _buildLoanSummary(),
                    const SizedBox(height: 20),
                    _buildHowItWorks(),
                    const SizedBox(height: 20),
                    _buildAutopay(),
                    const SizedBox(height: 16),
                    _buildTerms(),
                    const SizedBox(height: 20),
                    _buildProceedButton(),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'An initial, fully refundable ₹1 will be charged via Autopay for verification.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              'Loan Details - ${widget.amount} Personal Loan',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selected Amount:',
                  style: TextStyle(fontSize: 14, color: Color(0xFF4B5563))),
              const SizedBox(height: 6),
              Text(
                widget.amount,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const Icon(Icons.savings_outlined, size: 48, color: Color(0xFF6B7280)),
        ],
      ),
    );
  }

  Widget _buildLoanSummary() {
    final rows = [
      {'icon': Icons.medical_services_outlined, 'label': 'Purpose', 'value': widget.category ?? 'Personal Loan\n(Small Expense)'},
      {'icon': Icons.calendar_month_outlined, 'label': 'Tenure', 'value': '$_tenureMonths Months'},
      {'icon': Icons.trending_up, 'label': 'Interest Rate (p.a.)', 'value': '$_interestRate%'},
      {'icon': Icons.payments_outlined, 'label': 'Total Payable (incl. Autopay)', 'value': '₹${_totalPayable.toStringAsFixed(2)}'},
      {'icon': Icons.event_repeat_outlined, 'label': 'Monthly Installment (EMI)', 'value': '₹${_emi.toStringAsFixed(2)}'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Loan Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDCF5E4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: rows.map((row) {
              final isLast = row == rows.last;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: isLast
                      ? null
                      : const Border(
                          bottom: BorderSide(color: Color(0xFFB7E4C7), width: 0.5)),
                ),
                child: Row(
                  children: [
                    Icon(row['icon'] as IconData, size: 18, color: const Color(0xFF4A9B8E)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        row['label'] as String,
                        style: const TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
                      ),
                    ),
                    Text(
                      row['value'] as String,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHowItWorks() {
    final steps = [
      {'icon': Icons.badge_outlined, 'title': 'Verify Account', 'sub': 'Identity check'},
      {'icon': Icons.check_circle_outline, 'title': 'Instant Approval', 'sub': 'Decision made'},
      {'icon': Icons.account_balance_outlined, 'title': 'Disburse Funds', 'sub': 'Money sent to\nyour bank'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('How it Works',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: steps.map((step) {
              final colors = [
                const Color(0xFFDBEAFF),
                const Color(0xFFFFE4E6),
                const Color(0xFFFFF3D0),
              ];
              final idx = steps.indexOf(step);
              return Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: colors[idx],
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(step['icon'] as IconData, size: 26, color: const Color(0xFF4A9B8E)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step['title'] as String,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    step['sub'] as String,
                    style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAutopay() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9FE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Autopay Setup',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Color(0xFFEDE9FE),
                  child: Text('₹1', style: TextStyle(fontSize: 10, color: Color(0xFF4A9B8E), fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 10),
                Text('Autopay Registration: ₹1',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A1A2E))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerms() {
    return Row(
      children: [
        Checkbox(
          value: _agreed,
          onChanged: (v) => setState(() => _agreed = v ?? false),
          activeColor: const Color(0xFF4A9B8E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        const Expanded(
          child: Text(
            'I agree to the Terms & Conditions and Privacy Policy',
            style: TextStyle(fontSize: 13, color: Color(0xFF4B5563)),
          ),
        ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _agreed
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Application for ${widget.amount} submitted! ✅'),
                    backgroundColor: const Color(0xFF4A9B8E),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A9B8E),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFB0D4CF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 0,
        ),
        child: Text(
          'Register Autopay (₹1) &\nProceed with Application (${widget.amount})',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
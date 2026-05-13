import 'package:flutter/material.dart';

void main() {
  runApp(const EasyLoanApp());
}

class EasyLoanApp extends StatelessWidget {
  const EasyLoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyLoan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF76ABAE)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// --- HOME SCREEN ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _currentAmount = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section (Same as before)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 30),
                  const Spacer(),
                  const CircleAvatar(backgroundColor: Colors.grey, radius: 20),
                ],
              ),
              const SizedBox(height: 30),
              const Center(child: Text('EasyLoan', style: TextStyle(fontSize: 32))),
              const SizedBox(height: 30),

              // Loan Cards Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.4,
                children: [
                  _loanCard(context, "Personal Loan", "₹100", const Color(0xFFE3EAFF)),
                  _loanCard(context, "Personal Loan", "₹500", const Color(0xFFE0F7F6)),
                  _loanCard(context, "Personal Loan", "₹1000", const Color(0xFFE7F6E7)),
                  _loanCard(context, "Personal Loan", "₹2000", const Color(0xFFFFF4D8)),
                ],
              ),
              // ... Baaki ka home screen code wahi rahega ...
            ],
          ),
        ),
      ),
    );
  }

  Widget _loanCard(BuildContext context, String title, String amount, Color color) {
    return GestureDetector(
      onTap: () {
        // Navigating to Detail Screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoanDetailScreen(amount: amount)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(amount, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// --- LOAN DETAIL SCREEN (1000026372.png) ---
class LoanDetailScreen extends StatelessWidget {
  final String amount;
  const LoanDetailScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F9),
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
        title: Text('Loan Details - $amount Personal Loan', style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected Amount Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE3EAFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selected Amount:', style: TextStyle(fontSize: 16)),
                      Text(amount, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Icon(Icons.payments_outlined, size: 50, color: Colors.black54),
                ],
              ),
            ),
            const SizedBox(height: 25),

            const Text('Loan Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Summary Table
            _summaryRow(Icons.medical_services_outlined, "Purpose", "Personal Loan (Small Expense)", const Color(0xFFE7F6E7)),
            _summaryRow(Icons.calendar_today_outlined, "Tenure", "12 Months", Colors.white),
            _summaryRow(Icons.trending_up, "Interest Rate (p.a.)", "7.5%", const Color(0xFFE7F6E7)),
            _summaryRow(Icons.account_balance_wallet_outlined, "Total Payable (incl. Autopay)", "₹108.50", Colors.white),
            _summaryRow(Icons.receipt_long_outlined, "Monthly Installment (EMI)", "₹8.96", const Color(0xFFE3EAFF)),

            const SizedBox(height: 25),
            const Text('How it Works', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // Steps
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stepItem(Icons.badge_outlined, "Verify Account", "Identity check", const Color(0xFFE3EAFF)),
                _stepItem(Icons.check_circle_outline, "Instant Approval", "Decision made", const Color(0xFFFFF4D8)),
                _stepItem(Icons.account_balance_outlined, "Disburse Funds", "Money sent", const Color(0xFFE0F7F6)),
              ],
            ),

            const SizedBox(height: 30),

            // Autopay Section (Your Condition)
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.purple.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Autopay Setup', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      children: [
                        Icon(Icons.monetization_on_outlined, size: 20),
                        SizedBox(width: 10),
                        Text('Autopay Registration: ₹1'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.check_box, color: const Color(0xFF76ABAE)),
                const SizedBox(width: 10),
                const Expanded(child: Text('I agree to the Terms & Conditions and Privacy Policy', style: TextStyle(fontSize: 12))),
              ],
            ),

            const SizedBox(height: 20),

            // Final Action Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Logic for permanent autopay condition
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF76ABAE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register Autopay (₹1) &', style: const TextStyle(color: Colors.white, fontSize: 14)),
                    Text('Proceed with Application ($amount)', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(child: Text('An initial, fully refundable ₹1 will be charged via Autopay for verification.', style: TextStyle(fontSize: 10, color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(IconData icon, String title, String value, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _stepItem(IconData icon, String title, String sub, Color color) {
    return Column(
      children: [
        CircleAvatar(radius: 25, backgroundColor: color, child: Icon(icon, color: Colors.black87)),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        Text(sub, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }
}

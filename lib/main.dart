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
        fontFamily: 'sans-serif',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF76ABAE)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

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
              // Top Header: Menu, Search, Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, size: 30, color: Colors.black87),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Text('Search', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/219/219983.png'),
                    radius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'EasyLoan',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 1.2),
                ),
              ),
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
                  _loanCard("Personal Loan", "₹100", const Color(0xFFE3EAFF), Icons.paid_outlined),
                  _loanCard("Personal Loan", "₹500", const Color(0xFFE0F7F6), Icons.handshake_outlined),
                  _loanCard("Personal Loan", "₹1000", const Color(0xFFE7F6E7), Icons.account_balance_wallet_outlined),
                  _loanCard("Personal Loan", "₹2000", const Color(0xFFFFF4D8), Icons.account_balance_wallet_outlined),
                ],
              ),
              const SizedBox(height: 30),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Loan Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Swipe >', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _categoryItem("Medical", Icons.medical_services_outlined, const Color(0xFFE3EAFF)),
                    _categoryItem("Education", Icons.school_outlined, const Color(0xFFE7F6E7)),
                    _categoryItem("Travel", Icons.flight_takeoff_outlined, const Color(0xFFFFE5E5)),
                    _categoryItem("Business", Icons.business_center_outlined, const Color(0xFFFFF4D8)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Amount Selection Section
              const Text('Choose Your Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF76ABAE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '₹${_currentAmount.toInt()}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFF76ABAE),
                  inactiveTrackColor: Colors.grey.shade300,
                  thumbColor: Colors.white,
                  overlayColor: const Color(0xFF76ABAE).withOpacity(0.2),
                ),
                child: Slider(
                  value: _currentAmount,
                  min: 100,
                  max: 2000,
                  onChanged: (value) {
                    setState(() {
                      _currentAmount = value;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹100', style: TextStyle(color: Colors.grey)),
                    Text('₹1000', style: TextStyle(color: Colors.grey)),
                    Text('₹2000', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF76ABAE),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Get Started', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loanCard(String title, String amount, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(amount, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Icon(icon, size: 28, color: Colors.black54),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 30, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

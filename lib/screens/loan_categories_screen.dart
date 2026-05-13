import 'package:flutter/material.dart';
import 'loan_details_screen.dart';

class LoanCategoriesScreen extends StatefulWidget {
  final bool isTab;
  const LoanCategoriesScreen({super.key, this.isTab = false});

  @override
  State<LoanCategoriesScreen> createState() => _LoanCategoriesScreenState();
}

class _LoanCategoriesScreenState extends State<LoanCategoriesScreen> {
  double _amount = 1000;

  final List<Map<String, dynamic>> _categories = [
    {'title': 'Business Loans', 'sub': 'Grow Your Business', 'icon': Icons.business_center_outlined, 'color': Color(0xFFFFF3D0)},
    {'title': 'Medical Emergency', 'sub': 'Cover Healthcare Costs', 'icon': Icons.favorite_border, 'color': Color(0xFFDBEAFF)},
    {'title': 'Education Loans', 'sub': 'Invest in Your Future', 'icon': Icons.school_outlined, 'color': Color(0xFFD0F0EC)},
    {'title': 'Travel & Holidays', 'sub': 'Plan Your Next Trip', 'icon': Icons.flight_outlined, 'color': Color(0xFFFFF3D0)},
    {'title': 'Vehicle Loans', 'sub': 'New or Used Cars/Bikes', 'icon': Icons.directions_car_outlined, 'color': Color(0xFFEDE9FE)},
    {'title': 'Home Renovation', 'sub': 'Improve Your Home', 'icon': Icons.home_outlined, 'color': Color(0xFFFFE4E6)},
    {'title': 'Debt Consolidation', 'sub': 'Simplify Your Debts', 'icon': Icons.credit_card_outlined, 'color': Color(0xFFDBEAFF)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildCategoryGrid(),
                    const SizedBox(height: 24),
                    _buildAmountSection(),
                    const SizedBox(height: 20),
                    _buildStartButton(),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          if (!widget.isTab)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 14),
                  Icon(Icons.search, color: Color(0xFF9CA3AF), size: 18),
                  SizedBox(width: 8),
                  Text('Search', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFE0B2),
            ),
            child: const Icon(Icons.person, color: Color(0xFF4A9B8E), size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Explore Loan Categories',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final cat = _categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoanDetailsScreen(
                      amount: '₹${_amount.toInt()}',
                      color: cat['color'],
                      category: cat['title'],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: cat['color'],
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(cat['icon'], size: 22, color: const Color(0xFF4A9B8E)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      cat['title'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      cat['sub'],
                      style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose Your Amount',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: const Color(0xFF4A9B8E),
            inactiveTrackColor: const Color(0xFFE5E7EB),
            thumbColor: Colors.white,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            trackHeight: 5,
            overlayColor: const Color(0xFF4A9B8E).withOpacity(0.15),
          ),
          child: Slider(
            value: _amount,
            min: 100,
            max: 2000,
            divisions: 19,
            onChanged: (val) => setState(() => _amount = val),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('₹100', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            Text('₹1000', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
            Text('₹2000', style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          ],
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LoanDetailsScreen(
                amount: '₹${_amount.toInt()}',
                color: const Color(0xFFD0F0EC),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A9B8E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 0,
        ),
        child: Text(
          'Start with ₹${_amount.toInt()}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
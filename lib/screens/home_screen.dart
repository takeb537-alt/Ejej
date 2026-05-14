import 'package:flutter/material.dart';
import 'loan_details_screen.dart';
import 'loan_categories_screen.dart';
import 'profile_screen.dart';
import 'drawer_menu.dart';
import 'my_loans_screen.dart';
import 'loan_calculator_screen.dart';
import 'settings_screen.dart';
import 'manage_bank_screen.dart';
import 'notifications_screen.dart';
import 'support_screen.dart';
import 'about_screen.dart';
import 'invite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  double _loanAmount = 1000;
  bool _drawerOpen = false;

  final List<Map<String, dynamic>> _loanCards = [
    {
      'label': 'Personal Loan',
      'amount': '₹100',
      'color': Color(0xFFDBEAFF),
      'icon': Icons.monetization_on_outlined,
    },
    {
      'label': 'Personal Loan',
      'amount': '₹500',
      'color': Color(0xFFD0F0EC),
      'icon': Icons.savings_outlined,
    },
    {
      'label': 'Personal Loan',
      'amount': '₹1000',
      'color': Color(0xFFDCF5E4),
      'icon': Icons.account_balance_wallet_outlined,
    },
    {
      'label': 'Personal Loan',
      'amount': '₹2000',
      'color': Color(0xFFFFF3D0),
      'icon': Icons.payments_outlined,
    },
  ];

  final List<Map<String, dynamic>> _categories = [
    {
      'label': 'Medical',
      'icon': Icons.medical_services_outlined,
      'color': Color(0xFFDBEAFF),
    },
    {
      'label': 'Education',
      'icon': Icons.school_outlined,
      'color': Color(0xFFD0F0EC),
    },
    {
      'label': 'Travel',
      'icon': Icons.flight_outlined,
      'color': Color(0xFFFFE4E6),
    },
    {
      'label': 'Business',
      'icon': Icons.business_center_outlined,
      'color': Color(0xFFFFF3D0),
    },
    {
      'label': 'Vehicle',
      'icon': Icons.directions_car_outlined,
      'color': Color(0xFFEDE9FE),
    },
    {
      'label': 'Home',
      'icon': Icons.home_outlined,
      'color': Color(0xFFFFEDD5),
    },
  ];

  void _openDrawer() => setState(() => _drawerOpen = true);
  void _closeDrawer() => setState(() => _drawerOpen = false);

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return LoanCategoriesScreen(isTab: true);
      case 2:
        return ProfileScreen(isTab: true);
      default:
        return _buildHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: SafeArea(child: _getBody()),
          bottomNavigationBar: _buildBottomNav(),
        ),
        if (_drawerOpen)
          AppDrawer(onClose: _closeDrawer),
      ],
    );
  }

  // ─── HOME CONTENT ────────────────────────────────────────────────────────

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _buildTopBar(),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'EasyLoan',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildLoanGrid(),
          const SizedBox(height: 24),
          _buildSectionHeader('Loan Categories', onSwipe: () {
            setState(() => _currentIndex = 1);
          }),
          const SizedBox(height: 12),
          _buildCategoriesRow(),
          const SizedBox(height: 24),
          _buildAmountSlider(),
          const SizedBox(height: 24),
          _buildGetStartedButton(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ─── TOP BAR ─────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Row(
      children: [
        // Hamburger menu - DRAWER OPEN KARTA HAI
        GestureDetector(
          onTap: _openDrawer,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.menu,
              color: Color(0xFF1A1A2E),
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Search bar
        Expanded(
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              children: [
                SizedBox(width: 14),
                Icon(Icons.search, color: Color(0xFF9CA3AF), size: 18),
                SizedBox(width: 8),
                Text(
                  'Search',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Profile avatar - PROFILE TAB OPEN KARTA HAI
        GestureDetector(
          onTap: () => setState(() => _currentIndex = 2),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFE0B2),
              border: Border.all(color: const Color(0xFFFFCC80), width: 2),
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF4A9B8E),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  // ─── LOAN GRID ───────────────────────────────────────────────────────────

  Widget _buildLoanGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: _loanCards.length,
      itemBuilder: (context, index) {
        final card = _loanCards[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoanDetailsScreen(
                  amount: card['amount'] as String,
                  color: card['color'] as Color,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: card['color'] as Color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card['label'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF4B5563),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card['amount'] as String,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    Icon(
                      card['icon'] as IconData,
                      size: 22,
                      color: const Color(0xFF6B7280),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── SECTION HEADER ──────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title, {VoidCallback? onSwipe}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        if (onSwipe != null)
          GestureDetector(
            onTap: onSwipe,
            child: const Row(
              children: [
                Text(
                  'Swipe',
                  style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ─── CATEGORIES ROW ──────────────────────────────────────────────────────

  Widget _buildCategoriesRow() {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () => setState(() => _currentIndex = 1),
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: cat['color'] as Color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    cat['icon'] as IconData,
                    size: 26,
                    color: const Color(0xFF4A9B8E),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  cat['label'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF4B5563),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ─── AMOUNT SLIDER ───────────────────────────────────────────────────────

  Widget _buildAmountSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Your Amount',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 24),
        Stack(
          clipBehavior: Clip.none,
          children: [
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: const Color(0xFF4A9B8E),
                inactiveTrackColor: const Color(0xFFE5E7EB),
                thumbColor: Colors.white,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 10,
                ),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 18,
                ),
                trackHeight: 5,
                overlayColor: const Color(0xFF4A9B8E).withOpacity(0.15),
              ),
              child: Slider(
                value: _loanAmount,
                min: 100,
                max: 2000,
                divisions: 19,
                onChanged: (val) => setState(() => _loanAmount = val),
              ),
            ),
            Positioned(
              left: ((_loanAmount - 100) / 1900) *
                      (MediaQuery.of(context).size.width - 64) -
                  22,
              top: -32,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A9B8E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '₹${_loanAmount.toInt()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '₹100',
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
            ),
            Text(
              '₹1000',
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
            ),
            Text(
              '₹2000',
              style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
            ),
          ],
        ),
      ],
    );
  }

  // ─── GET STARTED BUTTON ──────────────────────────────────────────────────

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LoanDetailsScreen(
                amount: '₹${_loanAmount.toInt()}',
                color: const Color(0xFFD0F0EC),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A9B8E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // ─── BOTTOM NAVIGATION ───────────────────────────────────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF4A9B8E),
        unselectedItemColor: const Color(0xFF9CA3AF),
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
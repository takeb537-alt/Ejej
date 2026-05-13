import 'package:flutter/material.dart';
import 'dart:math';

class LoanCalculatorScreen extends StatefulWidget {
  const LoanCalculatorScreen({super.key});
  @override
  State<LoanCalculatorScreen> createState() => _LoanCalculatorScreenState();
}

class _LoanCalculatorScreenState extends State<LoanCalculatorScreen> {
  double _amount = 1000;
  double _rate = 7.5;
  double _tenure = 12;

  double get _emi {
    final r = _rate / 12 / 100;
    final n = _tenure;
    if (r == 0) return _amount / n;
    return (_amount * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
  }

  double get _total => _emi * _tenure;
  double get _interest => _total - _amount;

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
        title: const Text('Loan Calculator',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _resultCard(),
            const SizedBox(height: 20),
            _sliderCard('Loan Amount', '₹${_amount.toInt()}', _amount, 100, 50000, (v) => setState(() => _amount = v)),
            const SizedBox(height: 12),
            _sliderCard('Interest Rate (% p.a.)', '${_rate.toStringAsFixed(1)}%', _rate, 1, 30, (v) => setState(() => _rate = v), divisions: 58),
            const SizedBox(height: 12),
            _sliderCard('Tenure (Months)', '${_tenure.toInt()} mo', _tenure, 1, 60, (v) => setState(() => _tenure = v), divisions: 59),
            const SizedBox(height: 20),
            _breakdownCard(),
          ],
        ),
      ),
    );
  }

  Widget _resultCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF4A9B8E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('Monthly EMI', style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          Text('₹${_emi.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _resultItem('Principal', '₹${_amount.toInt()}'),
              _resultItem('Interest', '₹${_interest.toStringAsFixed(0)}'),
              _resultItem('Total', '₹${_total.toStringAsFixed(0)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _resultItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }

  Widget _sliderCard(String label, String value, double current, double min, double max,
      ValueChanged<double> onChanged, {int? divisions}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD0F0EC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color(0xFF4A9B8E),
              inactiveTrackColor: const Color(0xFFE5E7EB),
              thumbColor: const Color(0xFF4A9B8E),
              trackHeight: 4,
              overlayColor: const Color(0xFF4A9B8E).withOpacity(0.12),
            ),
            child: Slider(
              value: current,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _breakdownCard() {
    final principalPct = (_amount / _total * 100).toStringAsFixed(1);
    final interestPct = (_interest / _total * 100).toStringAsFixed(1);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _breakdownRow('Principal', principalPct, const Color(0xFF4A9B8E)),
          const SizedBox(height: 8),
          _breakdownRow('Interest', interestPct, const Color(0xFFFFB347)),
        ],
      ),
    );
  }

  Widget _breakdownRow(String label, String pct, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
        Text('$pct%', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
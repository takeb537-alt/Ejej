import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/medicine.dart';
import '../services/database_service.dart';
import '../services/alarm_service.dart';
import '../widgets/medicine_card.dart';
import '../widgets/add_medicine_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Medicine> _medicines = [];
  bool _isHindi = true; // डिफ़ॉल्ट भाषा हिंदी

  @override
  void initState() {
    super.initState();
    _loadLanguagePreference();
    _refreshMedicines();
    AlarmService.init(context); // अलार्म सर्विस शुरू करें
  }

  // भाषा प्राथमिकता लोड करें
  void _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isHindi = prefs.getBool('isHindi') ?? true;
    });
  }

  // भाषा बदलें और सेव करें
  void _toggleLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isHindi = !_isHindi;
      prefs.setBool('isHindi', _isHindi);
    });
  }

  // लोकल DB से लिस्ट अपडेट करें
  Future<void> _refreshMedicines() async {
    final data = await DatabaseService.instance.fetchAll();
    setState(() {
      _medicines = data;
    });
  }

  // नई दवाई जोड़ने का प्रोसेस
  void _addMedicine(Medicine medicine) async {
    await DatabaseService.instance.insert(medicine);
    _refreshMedicines();
    await AlarmService.scheduleAlarm(medicine); // अलार्म शेड्यूलर को भेजें
  }

  // दवाई डिलीट करने का प्रोसेस
  void _deleteMedicine(int id) async {
    await DatabaseService.instance.delete(id);
    _refreshMedicines();
  }

  void _showAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => AddMedicineSheet(onSave: _addMedicine, isHindi: _isHindi),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_isHindi ? 'दवाई रिमाइंडर 💊' : 'Medicine Reminder 💊', 
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF10B981),
        actions: [
          // भाषा बदलने का बटन (English / हिंदी)
          TextButton(
            onPressed: _toggleLanguage,
            child: Text(
              _isHindi ? 'English' : 'हिंदी',
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // मेडिकल डिस्क्लेमर बैनर
            Container(
              width: double.infinity,
              color: Colors.amber.shade100,
              padding: const EdgeInsets.all(10),
              child: Text(
                _isHindi 
                  ? '⚠️ सलाह: कृपया सही समय पर डॉक्टर के निर्देशानुसार ही दवाई लें।' 
                  : '⚠️ Disclaimer: Please take medicine strictly as advised by your doctor.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),
            
            // दवाई सूची क्षेत्र
            Expanded(
              child: _medicines.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('⏰', style: TextStyle(fontSize: 64)),
                          const SizedBox(height: 10),
                          Text(
                            _isHindi ? 'कोई दवाई नहीं जोड़ी गई है।' : 'No medicines added yet.',
                            style: const TextStyle(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _medicines.length,
                      itemBuilder: (context, index) {
                        final med = _medicines[index];
                        return MedicineCard(
                          medicine: med,
                          onDelete: () => _deleteMedicine(med.id!),
                        );
                      },
                    ),
            ),
            
            // नीचे बड़ा 'दवाई जोड़ें' बटन
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: _showAddSheet,
                  child: Text(
                    _isHindi ? '➕ नई दवाई जोड़ें' : '➕ Add Medicine',
                    style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

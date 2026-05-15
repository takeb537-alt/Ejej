import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/permission_service.dart';

void main() async {
  // यकीनी बनाएं कि विजेट्स पूरी तरह बाइंड हो चुके हैं
  WidgetsFlutterBinding.ensureInitialized();
  
  // ऐप खुलते ही परमिशन मांगें
  await PermissionService.requestAllPermissions();

  runApp(const MedicineReminderApp());
}

class MedicineReminderApp extends StatelessWidget {
  const MedicineReminderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Reminder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF10B981),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', // स्टैंडर्ड फॉन्ट जो हर डिवाइस में उपलब्ध हो
      ),
      home: const HomeScreen(),
    );
  }
}

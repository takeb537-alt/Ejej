import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../services/voice_service.dart';

class AlarmScreen extends StatefulWidget {
  final String medName;
  final String dosage;
  final String? voicePath;

  const AlarmScreen({
    Key? key,
    required this.medName,
    required this.dosage,
    this.voicePath,
  }) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> with SingleTickerProviderStateMixin {
  final VoiceService _voiceService = VoiceService();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    
    // घंटी का एनिमेशन (Bell Animation)
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    // लगातार वाइब्रेशन शुरू करें
    _startAlarmEffects();
  }

  void _startAlarmEffects() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [500, 1000, 500, 1000], repeat: 0);
    }
    // अगर आवाज़ रिकॉर्डेड है तो लूप में बजाएं
    if (widget.voicePath != null && widget.voicePath!.isNotEmpty) {
      _voiceService.playVoice(widget.voicePath!, loop: true);
    }
  }

  void _stopAlarm() {
    Vibration.cancel();
    _voiceService.stopVoice();
    _animationController.dispose();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              '🔔 दवाई का समय! 🔔',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            
            // एनिमेटेड बड़ी घंटी
            RotationTransition(
              turns: Tween(begin: -0.05, end: 0.05).animate(_animationController),
              child: const Text('🔔', style: TextStyle(fontSize: 100)),
            ),

            // दवाई और खुराक की जानकारी (बड़े अक्षर)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    widget.medName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'खुराक: ${widget.dosage}',
                    style: const TextStyle(fontSize: 26, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // बड़ा लाल STOP बटन
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                height: 70, // बुजुर्गों के लिए बड़ा बटन
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444), // Red color
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: _stopAlarm,
                  child: const Text(
                    '🛑 बंद करें (STOP)',
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
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

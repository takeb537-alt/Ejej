import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/voice_service.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onDelete;

  const MedicineCard({Key? key, required this.medicine, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VoiceService voiceService = VoiceService();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Text('💊', style: TextStyle(fontSize: 36)),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(medicine.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('खुराक: ${medicine.dosage}', style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text('⏰ समय: ${medicine.time}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green)),
                ],
              ),
            ),
            
            // अगर ऑडियो रिकॉर्डेड है तो प्ले बटन दिखाएं
            if (medicine.voicePath != null && medicine.voicePath!.isNotEmpty)
              IconButton(
                icon: const Text('▶️', style: TextStyle(fontSize: 28)),
                onPressed: () => voiceService.playVoice(medicine.voicePath!),
              ),
              
            // डिलीट बटन
            IconButton(
              icon: const Text('🗑️', style: TextStyle(fontSize: 28)),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/voice_service.dart';

class AddMedicineSheet extends StatefulWidget {
  final Function(Medicine) onSave;
  final bool isHindi;

  const AddMedicineSheet({Key? key, required this.onSave, required this.isHindi}) : super(key: key);

  @override
  State<AddMedicineSheet> createState() => _AddMedicineSheetState();
}

class _AddMedicineSheetState extends State<AddMedicineSheet> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  
  final VoiceService _voiceService = VoiceService();
  bool _isRecording = false;
  String? _recordedVoicePath;

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // भाषा के आधार पर टेक्स्ट बदलें
    String title = widget.isHindi ? 'नई दवाई जोड़ें' : 'Add New Medicine';
    String nameHint = widget.isHindi ? 'दवाई का नाम (e.g., PCM)' : 'Medicine Name';
    String dosageHint = widget.isHindi ? 'खुराक (e.g., 1 गोली)' : 'Dosage (e.g., 1 Pill)';
    String timeLabel = widget.isHindi ? 'समय चुनें⏰:' : 'Select Time⏰:';
    String recordText = _isRecording 
        ? (widget.isHindi ? '🛑 रिकॉर्डिंग हो रही है...' : '🛑 Recording...') 
        : (widget.isHindi ? '🎤 आवाज़ रिकॉर्ड करें (दबाकर रखें)' : '🎤 Hold to Record Voice');
    String saveBtnText = widget.isHindi ? '💾 सुरक्षित करें (SAVE)' : '💾 SAVE';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // कीबोर्ड के ऊपर रखने के लिए
        left: 20, right: 20, top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            
            // नाम इनपुट
            TextField(
              controller: _nameController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: nameHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            
            // खुराक इनपुट
            TextField(
              controller: _dosageController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: dosageHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            
            // टाइम पिकर रो
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$timeLabel ${_selectedTime.format(context)}', style: const TextStyle(fontSize: 18)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size(100, 56)),
                  onPressed: _pickTime,
                  child: const Text('⏰', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // वॉयस रिकॉर्डर बटन (Hold to Record)
            GestureDetector(
              onLongPressStart: (_) async {
                setState(() { _isRecording = true; });
                await _voiceService.startRecording();
              },
              onLongPressEnd: (_) async {
                String? path = await _voiceService.stopRecording();
                setState(() { 
                  _isRecording = false; 
                  _recordedVoicePath = path;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(widget.isHindi ? '🎤 आवाज़ रिकॉर्ड हो गई!' : '🎤 Voice Recorded!'))
                );
              },
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: _isRecording ? Colors.red.shade100 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _isRecording ? Colors.red : Colors.grey),
                ),
                alignment: Alignment.center,
                child: Text(recordText, style: TextStyle(fontSize: 18, color: _isRecording ? Colors.red : Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            
            // सेव बटन
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                onPressed: () {
                  if (_nameController.text.isNotEmpty && _dosageController.text.isNotEmpty) {
                    final formattedHour = _selectedTime.hour.toString().padLeft(2, '0');
                    final formattedMinute = _selectedTime.minute.toString().padLeft(2, '0');
                    
                    final newMed = Medicine(
                      name: _nameController.text,
                      dosage: _dosageController.text,
                      time: "$formattedHour:$formattedMinute",
                      voicePath: _recordedVoicePath,
                    );
                    widget.onSave(newMed);
                    Navigator.pop(context);
                  }
                },
                child: Text(saveBtnText, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';

class VoiceService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentPath;

  // रिकॉर्डिंग शुरू करें
  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String path = '${appDir.path}/med_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      _currentPath = path;
      
      await _recorder.start(const RecordConfig(), path: path);
    }
  }

  // रिकॉर्डिंग रोकें और फ़ाइल का पाथ वापस करें
  Future<String?> stopRecording() async {
    final path = await _recorder.stop();
    return path ?? _currentPath;
  }

  // रिकॉर्ड की गई आवाज़ बजाएं
  Future<void> playVoice(String path, {bool loop = false}) async {
    if (loop) {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else {
      await _audioPlayer.setReleaseMode(ReleaseMode.release);
    }
    await _audioPlayer.play(DeviceFileSource(path));
  }

  // आवाज़ बंद करें
  Future<void> stopVoice() async {
    await _audioPlayer.stop();
  }
}

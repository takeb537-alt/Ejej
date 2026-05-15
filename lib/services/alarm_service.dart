import 'package:flutter_local_notifications/flutter_local_notifications;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/medicine.dart';
import '../widgets/alarm_screen.dart';

class AlarmService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // जब नोटिफिकेशन पर क्लिक हो तो फुल-स्क्रीन अलार्म खोलें
        if (details.payload != null) {
          final parts = details.payload!.split('|');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlarmScreen(
                medName: parts[0],
                dosage: parts[1],
                voicePath: parts.length > 2 && parts[2].isNotEmpty ? parts[2] : null,
              ),
            ),
          );
        }
      },
    );
  }

  // अलार्म शेड्यूल करने का फंक्शन
  static Future<void> scheduleAlarm(Medicine medicine) async {
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat("HH:mm");
    final DateTime alarmTime = format.parse(medicine.time);
    
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      alarmTime.hour,
      alarmTime.minute,
    );

    // अगर समय निकल गया है तो अगले दिन के लिए सेट करें
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'med_alarm_channel_id',
      'Medicine Alarms',
      channelDescription: 'Channel for Medicine Reminder Alarms',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true, // लॉक स्क्रीन पर भी दिखेगा
      playSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    // नोट: सिम्पल टेस्टिंग के लिए तुरंत या समय अवधि के बाद ट्रिगर करने की व्यवस्था
    final int id = medicine.id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String payloadData = "${medicine.name}|${medicine.dosage}|${medicine.voicePath ?? ''}";

    await _notificationsPlugin.show(
      id,
      '💊 दवाई का समय! (Medicine Time)',
      '${medicine.name} - ${medicine.dosage}',
      platformDetails,
      payload: payloadData,
    );
  }
}

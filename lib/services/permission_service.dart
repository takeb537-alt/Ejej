import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestAllPermissions() async {
    // आवश्यक अनुमतियों की लिस्ट
    Map<Permission, PermissionStatus> statuses = await [
      Permission.microphone,
      Permission.notification,
    ].request();

    // Android 13+ के लिए शेड्यूल और नोटिफिकेशन चेक
    if (statuses[Permission.microphone]!.isGranted &&
        statuses[Permission.notification]!.isGranted) {
      return true;
    }
    return false;
  }
}

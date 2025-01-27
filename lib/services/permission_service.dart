import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> initialize() async {
    try {
      await _requestPermissions();
    } catch (e) {
      print('Permission initialization error: $e');
    }
  }

  static Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.accessNotificationPolicy,
    ].request();

    statuses.forEach((permission, status) {
      print('$permission: $status');
    });
  }

  static Future<bool> checkAndRequestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final status = await permission.request();
      return status.isGranted;
    }
  }
}

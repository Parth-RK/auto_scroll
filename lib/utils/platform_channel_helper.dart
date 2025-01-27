import 'package:flutter/services.dart';

class PlatformChannelHelper {
  static const platform = MethodChannel('auto_clicker/native');

  static Future<void> simulateClick(double x, double y) async {
    try {
      await platform.invokeMethod('simulateClick', {
        'x': x,
        'y': y,
      });
    } on PlatformException catch (e) {
      print('Failed to simulate click: ${e.message}');
    }
  }

  static Future<bool> requestAccessibilityPermission() async {
    try {
      final bool result = await platform.invokeMethod('requestAccessibilityPermission');
      return result;
    } on PlatformException catch (e) {
      print('Failed to request permission: ${e.message}');
      return false;
    }
  }
}

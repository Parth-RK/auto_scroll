import 'package:flutter/services.dart';
import '../models/click_point.dart';

class AccessibilityService {
  static const platform = MethodChannel('com.example.auto_scroll/accessibility');

  Future<bool> requestAccessibilityPermission() async {
    try {
      final bool result = await platform.invokeMethod('requestAccessibilityPermission');
      return result;
    } on PlatformException catch (e) {
      print('Failed to request accessibility permission: ${e.message}');
      return false;
    }
  }

  Future<void> performClick(ClickPoint point) async {
    try {
      await platform.invokeMethod('performClick', point.toJson());
    } on PlatformException catch (e) {
      print('Failed to perform click: ${e.message}');
    }
  }
}

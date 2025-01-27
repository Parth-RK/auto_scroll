import 'package:flutter/services.dart';

class OverlayService {
  static const platform = MethodChannel('com.example.auto_scroll/overlay');
  
  Future<bool> requestOverlayPermission() async {
    try {
      final bool result = await platform.invokeMethod('requestOverlayPermission');
      return result;
    } on PlatformException catch (e) {
      print('Failed to request overlay permission: ${e.message}');
      return false;
    }
  }

  Future<void> showOverlay() async {
    try {
      await platform.invokeMethod('showOverlay');
    } on PlatformException catch (e) {
      print('Failed to show overlay: ${e.message}');
    }
  }

  Future<void> hideOverlay() async {
    try {
      await platform.invokeMethod('hideOverlay');
    } on PlatformException catch (e) {
      print('Failed to hide overlay: ${e.message}');
    }
  }
}

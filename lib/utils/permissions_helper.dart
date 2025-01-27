import 'package:flutter/material.dart';
import 'platform_channel_helper.dart';

class PermissionsHelper {
  static Future<bool> checkAndRequestPermissions(BuildContext context) async {
    final hasPermission = await PlatformChannelHelper.requestAccessibilityPermission();
    
    if (!hasPermission) {
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permission Required'),
            content: const Text('This app needs accessibility permission to simulate clicks.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
    
    return hasPermission;
  }
}

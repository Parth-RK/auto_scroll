import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool isOverlayGranted = false;
  bool isAccessibilityGranted = false;

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    isOverlayGranted = await Permission.systemAlertWindow.isGranted;
    // For accessibility, we need to check if service is enabled
    isAccessibilityGranted = await const MethodChannel('accessibility_channel')
        .invokeMethod('checkAccessibilityPermission');
    setState(() {});
  }

  Widget _buildPermissionTile({
    required String title,
    required bool isGranted,
    required VoidCallback onRequest,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGranted ? Icons.check_circle : Icons.error,
            color: isGranted ? Colors.green : Colors.red,
          ),
          if (!isGranted)
            TextButton(
              onPressed: onRequest,
              child: Text('Grant'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Permissions')),
      body: Column(
        children: [
          _buildPermissionTile(
            title: 'Overlay Permission',
            isGranted: isOverlayGranted,
            onRequest: () async {
              await Permission.systemAlertWindow.request();
              checkPermissions();
            },
          ),
          _buildPermissionTile(
            title: 'Accessibility Permission',
            isGranted: isAccessibilityGranted,
            onRequest: () async {
              await const MethodChannel('accessibility_channel')
                  .invokeMethod('openAccessibilitySettings');
              checkPermissions();
            },
          ),
          Spacer(),
          if (isOverlayGranted && isAccessibilityGranted)
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: Text('Continue to Settings'),
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'services/permission_service.dart';
import 'screens/home_screen.dart';
import 'screens/permission_screen.dart';
import 'screens/settings_screen.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Initialize services
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await PermissionService.initialize();
    
    runApp(MyApp());
  } catch (e) {
    debugPrint('Initialization error: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Scroll',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PermissionScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}

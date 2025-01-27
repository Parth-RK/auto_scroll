import 'package:flutter/material.dart';
import '../db/preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _overlayOpacity = 0.7;
  double _overlaySize = 60.0;
  bool _enableVibration = true;
  bool _enableSound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Overlay Opacity'),
            subtitle: Slider(
              value: _overlayOpacity,
              min: 0.1,
              max: 1.0,
              onChanged: (value) {
                setState(() => _overlayOpacity = value);
              },
            ),
          ),
          ListTile(
            title: const Text('Overlay Size'),
            subtitle: Slider(
              value: _overlaySize,
              min: 40.0,
              max: 100.0,
              onChanged: (value) {
                setState(() => _overlaySize = value);
              },
            ),
          ),
          SwitchListTile(
            title: const Text('Vibration'),
            value: _enableVibration,
            onChanged: (value) {
              setState(() => _enableVibration = value);
            },
          ),
          SwitchListTile(
            title: const Text('Sound'),
            value: _enableSound,
            onChanged: (value) {
              setState(() => _enableSound = value);
            },
          ),
        ],
      ),
    );
  }
}

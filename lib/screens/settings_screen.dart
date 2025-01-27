// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/preferences_service.dart';
import '../services/overlay_service.dart'; 

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
  final _scrollController = TextEditingController(text: '2000');
  final _preferences = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await _preferences;
    setState(() {
      _scrollController.text = 
          (prefs.getInt('scrollInterval') ?? 2000).toString();
    });
  }

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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _scrollController,
                  decoration: const InputDecoration(
                    labelText: 'Scroll Interval (ms)',
                    helperText: 'Time between scrolls in milliseconds',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await _preferences;
                    await prefs.setInt('scrollInterval', 
                        int.parse(_scrollController.text));
                    final service = OverlayService();
                    await service.showOverlay();
                    Navigator.pop(context);
                  },
                  child: const Text('Start Service'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/click_point.dart';
import 'settings_screen.dart';
import 'templates_screen.dart'; 
import '../db/preferences_service.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ClickPoint> _clickPoints = [];
  bool _isRunning = false;
  late PreferencesService _preferencesService;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _preferencesService = PreferencesService(prefs);
  }

  Future<void> _navigateToSettings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  Future<void> _navigateToTemplates() async {
    final prefs = await SharedPreferences.getInstance();
    final List<ClickPoint>? template = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemplatesScreen(
          preferencesService: PreferencesService(prefs),
        ),
      ),
    );

    if (template != null && mounted) {
      setState(() {
        _clickPoints.clear();
        _clickPoints.addAll(template);
      });
    }
  }

  Future<void> _showSaveTemplateDialog() async {
    final controller = TextEditingController();
    final String? name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Template'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Template Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (name != null && name.isNotEmpty && mounted) {
      await _preferencesService.saveTemplate(name, _clickPoints);
    }
    controller.dispose();
  }

  void _toggleRunning() {
    setState(() {
      _isRunning = !_isRunning;
    });
    // TODO: Implement start/stop logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Scroll'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _showSaveTemplateDialog,
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: _navigateToTemplates,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _navigateToSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _clickPoints.length,
              itemBuilder: (context, index) {
                final point = _clickPoints[index];
                return ListTile(
                  title: Text('Point ${point.id}'),
                  subtitle: Text('X: ${point.x}, Y: ${point.y}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _clickPoints.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _toggleRunning,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRunning ? Colors.red : Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text(_isRunning ? 'Stop' : 'Start'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new click point
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

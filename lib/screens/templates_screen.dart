import 'package:flutter/material.dart';
import '../db/preferences_service.dart';
import '../models/click_point.dart';

class TemplatesScreen extends StatefulWidget {
  final PreferencesService preferencesService;

  const TemplatesScreen({super.key, required this.preferencesService});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  late Map<String, List<dynamic>> _templates;

  @override
  void initState() {
    super.initState();
    _templates = widget.preferencesService.getTemplates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Templates'),
      ),
      body: ListView.builder(
        itemCount: _templates.length,
        itemBuilder: (context, index) {
          final name = _templates.keys.elementAt(index);
          final points = _templates[name]!;
          return ListTile(
            title: Text(name),
            subtitle: Text('${points.length} points'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTemplate(name),
            ),
            onTap: () => _loadTemplate(name, points),
          );
        },
      ),
    );
  }

  void _deleteTemplate(String name) {
    setState(() {
      _templates.remove(name);
      widget.preferencesService.saveTemplate(name, []);
    });
  }

  void _loadTemplate(String name, List<dynamic> points) {
    final clickPoints = points
        .map((p) => ClickPoint.fromJson(Map<String, dynamic>.from(p)))
        .toList();
    Navigator.pop(context, clickPoints);
  }
}

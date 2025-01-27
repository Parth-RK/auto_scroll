import 'package:flutter/material.dart';
import '../models/click_point.dart';

class ClickConfigurationScreen extends StatefulWidget {
  final ClickPoint? clickPoint;
  
  const ClickConfigurationScreen({super.key, this.clickPoint});

  @override
  State<ClickConfigurationScreen> createState() => _ClickConfigurationScreenState();
}

class _ClickConfigurationScreenState extends State<ClickConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  late double _x;
  late double _y;
  late int _delay;
  late int _interval;
  late int _repetitions;

  @override
  void initState() {
    super.initState();
    _x = widget.clickPoint?.x ?? 0;
    _y = widget.clickPoint?.y ?? 0;
    _delay = widget.clickPoint?.delay ?? 0;
    _interval = widget.clickPoint?.interval ?? 1000;
    _repetitions = widget.clickPoint?.repetitions ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clickPoint == null ? 'New Click Point' : 'Edit Click Point'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              initialValue: _x.toString(),
              decoration: const InputDecoration(labelText: 'X Coordinate'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _x = double.parse(value ?? '0'),
            ),
            TextFormField(
              initialValue: _y.toString(),
              decoration: const InputDecoration(labelText: 'Y Coordinate'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _y = double.parse(value ?? '0'),
            ),
            TextFormField(
              initialValue: _interval.toString(),
              decoration: const InputDecoration(labelText: 'Interval (ms)'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _interval = int.parse(value ?? '1000'),
            ),
            TextFormField(
              initialValue: _repetitions.toString(),
              decoration: const InputDecoration(labelText: 'Repetitions'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _repetitions = int.parse(value ?? '1'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveClickPoint,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveClickPoint() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final clickPoint = ClickPoint(
        id: widget.clickPoint?.id ?? DateTime.now().millisecondsSinceEpoch,
        x: _x,
        y: _y,
        delay: _delay,
        interval: _interval,
        repetitions: _repetitions,
      );
      Navigator.pop(context, clickPoint);
    }
  }
}

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/click_point.dart';

class PreferencesService {
  static const String _overlayOpacityKey = 'overlay_opacity';
  static const String _overlaySizeKey = 'overlay_size';
  static const String _enableVibrationKey = 'enable_vibration';
  static const String _enableSoundKey = 'enable_sound';
  static const String _templatesKey = 'templates';

  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  Future<void> saveSettings({
    required double overlayOpacity,
    required double overlaySize,
    required bool enableVibration,
    required bool enableSound,
  }) async {
    await _prefs.setDouble(_overlayOpacityKey, overlayOpacity);
    await _prefs.setDouble(_overlaySizeKey, overlaySize);
    await _prefs.setBool(_enableVibrationKey, enableVibration);
    await _prefs.setBool(_enableSoundKey, enableSound);
  }

  Future<void> saveTemplate(String name, List<ClickPoint> points) async {
    final templates = getTemplates();
    templates[name] = points.map((p) => p.toJson()).toList();
    await _prefs.setString(_templatesKey, jsonEncode(templates));
  }

  Map<String, List<dynamic>> getTemplates() {
    final String? data = _prefs.getString(_templatesKey);
    if (data == null) return {};
    return Map<String, List<dynamic>>.from(jsonDecode(data));
  }
}

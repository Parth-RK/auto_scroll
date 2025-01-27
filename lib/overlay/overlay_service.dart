import 'package:flutter/material.dart';
import 'dart:async';
import '../models/click_point.dart';
import '../utils/platform_channel_helper.dart';
import 'overlay_widget.dart';

class OverlayService {
  OverlayEntry? _overlayEntry;
  bool _isRunning = false;
  List<ClickPoint> _points = [];
  Timer? _clickTimer;

  void showOverlay(BuildContext context, List<ClickPoint> points) {
    _points = points;
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (context) => OverlayWidget(
        points: points,
        onClose: () => hideOverlay(),
        onStart: _toggleClicking,
        isRunning: _isRunning,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hideOverlay() {
    _stopClicking();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleClicking() {
    if (_isRunning) {
      _stopClicking();
    } else {
      _startClicking();
    }
  }

  void _startClicking() {
    _isRunning = true;
    _overlayEntry?.markNeedsBuild();
    
    var index = 0;
    _clickTimer = Timer.periodic(
      Duration(milliseconds: _points[index].delay),
      (timer) async {
        if (!_isRunning) {
          timer.cancel();
          return;
        }

        await PlatformChannelHelper.simulateClick(
          _points[index].x,
          _points[index].y,
        );

        index = (index + 1) % _points.length;
      },
    );
  }

  void _stopClicking() {
    _isRunning = false;
    _clickTimer?.cancel();
    _clickTimer = null;
    _overlayEntry?.markNeedsBuild();
  }

  void dispose() {
    hideOverlay();
  }
}

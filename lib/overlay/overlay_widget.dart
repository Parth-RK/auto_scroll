import 'package:flutter/material.dart';
import '../models/click_point.dart';

class OverlayWidget extends StatelessWidget {
  final List<ClickPoint> points;
  final VoidCallback onClose;
  final VoidCallback onStart;
  final bool isRunning;

  const OverlayWidget({
    Key? key,
    required this.points,
    required this.onClose,
    required this.onStart,
    required this.isRunning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      top: 100,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(isRunning ? Icons.stop : Icons.play_arrow),
                onPressed: onStart,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math';
import '../core/constants/app_colors.dart';

class VoiceWaveWidget extends StatefulWidget {
  final bool isRecording;

  const VoiceWaveWidget({super.key, required this.isRecording});

  @override
  State<VoiceWaveWidget> createState() => _VoiceWaveWidgetState();
}

class _VoiceWaveWidgetState extends State<VoiceWaveWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(20, (i) {
            final height = widget.isRecording
                ? 10 + (_random.nextDouble() * 60 * _controller.value)
                : 4.0;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 4,
                height: height,
                decoration: BoxDecoration(
                  color: widget.isRecording ? AppColors.error : AppColors.textSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
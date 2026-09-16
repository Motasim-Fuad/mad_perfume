import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:madperfume/core/constants/app_colors.dart';

class AnimatedCircularLoader extends StatefulWidget {
  const AnimatedCircularLoader({
    super.key,
    this.size = 36,
    this.color = AppColors.lilac,
  });

  final double size;
  final Color color;

  @override
  State<AnimatedCircularLoader> createState() => _AnimatedCircularLoaderState();
}

class _AnimatedCircularLoaderState extends State<AnimatedCircularLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Transform.rotate(
          angle: _controller.value * math.pi * 2,
          child: CustomPaint(painter: _LoaderPainter(color: widget.color)),
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  const _LoaderPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.45),
          color,
        ],
        stops: const [0, 0.58, 1],
      ).createShader(rect);
    canvas.drawArc(
      rect.deflate(size.width * 0.12),
      0,
      math.pi * 1.55,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _LoaderPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

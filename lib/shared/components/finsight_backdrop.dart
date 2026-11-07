import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class FinsightBackdrop extends StatelessWidget {
  const FinsightBackdrop({
    super.key,
    required this.child,
    this.showBottomWaves = true,
  });

  final Widget child;
  final bool showBottomWaves;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: ColoredBox(color: AppColors.ivory)),
        if (showBottomWaves)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: CustomPaint(
                size: const Size(double.infinity, 220),
                painter: _BackdropWavePainter(),
              ),
            ),
          ),
        child,
      ],
    );
  }
}

class _BackdropWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.mint.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.45)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.15,
        size.width * 0.55,
        size.height * 0.85,
        size.width,
        size.height * 0.35,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BackdropWavePainter oldDelegate) => false;
}

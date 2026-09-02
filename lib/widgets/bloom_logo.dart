import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/bloom_colors.dart';

class BloomLogo extends StatelessWidget {
  const BloomLogo({super.key, this.size = 40, this.showWordmark = false});

  final double size;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    final mark = SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _BloomMarkPainter()),
    );
    if (!showWordmark) return mark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        SizedBox(width: size * 0.28),
        Text(
          'Bloom',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: BloomColors.primary,
                fontSize: size * 0.55,
                height: 1,
              ),
        ),
      ],
    );
  }
}

class _BloomMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    canvas.drawCircle(c, r, Paint()..color = BloomColors.card);

    final petalPaint = Paint()..color = BloomColors.primaryContainer;
    final innerPaint = Paint()..color = const Color(0xFFA8687A);
    for (var i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + i * (2 * math.pi / 5);
      final path = Path();
      final tip = c + Offset(math.cos(angle), math.sin(angle)) * r * 0.78;
      final left = c +
          Offset(
            math.cos(angle - 0.62),
            math.sin(angle - 0.62),
          ) *
              r *
              0.28;
      final right = c +
          Offset(
            math.cos(angle + 0.62),
            math.sin(angle + 0.62),
          ) *
              r *
              0.28;
      path.moveTo(c.dx, c.dy);
      path.quadraticBezierTo(left.dx, left.dy, tip.dx, tip.dy);
      path.quadraticBezierTo(right.dx, right.dy, c.dx, c.dy);
      canvas.drawPath(path, petalPaint);
      canvas.drawCircle(
        c + Offset(math.cos(angle), math.sin(angle)) * r * 0.38,
        r * 0.08,
        innerPaint,
      );
    }
    canvas.drawCircle(c, r * 0.16, Paint()..color = const Color(0xFFFBF8F1));
    canvas.drawCircle(c, r * 0.08, Paint()..color = BloomColors.secondary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

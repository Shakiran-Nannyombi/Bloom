import 'package:flutter/material.dart';

import '../theme/bloom_colors.dart';

class BloomLogo extends StatelessWidget {
  const BloomLogo({super.key, this.size = 40, this.showWordmark = false});

  final double size;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    final mark = Image.asset(
      'assets/images/logo.png',
      width: size,
      height: size,
      filterQuality: FilterQuality.high,
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

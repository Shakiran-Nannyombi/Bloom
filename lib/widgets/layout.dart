import 'package:flutter/material.dart';

import '../theme/bloom_colors.dart';
import 'bloom_logo.dart';

bool isWideLayout(BuildContext context) => MediaQuery.sizeOf(context).width >= 960;

class BloomPage extends StatelessWidget {
  const BloomPage({
    super.key,
    required this.child,
    this.maxWidth,
    this.fill = false,
  });

  final Widget child;
  final double? maxWidth;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    final wide = isWideLayout(context);
    final pad = EdgeInsets.fromLTRB(
      wide ? 48 : 20,
      wide ? 28 : 16,
      wide ? 48 : 20,
      wide ? 40 : 24,
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxWidth.isFinite
            ? constraints.maxWidth - pad.horizontal
            : 1200.0;
        final width = maxWidth == null
            ? available.clamp(0, double.infinity).toDouble()
            : available.clamp(0, maxWidth!).toDouble();
        final height = fill && constraints.maxHeight.isFinite
            ? (constraints.maxHeight - pad.vertical).clamp(0, double.infinity).toDouble()
            : null;
        return Padding(
          padding: pad,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: width,
              height: height,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class SubpageScaffold extends StatelessWidget {
  const SubpageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
  });

  final String title;
  final Widget body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Row(
          children: [
            const BloomLogo(size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: BloomColors.primary,
                    ),
              ),
            ),
          ],
        ),
        actions: actions,
      ),
      body: body,
    );
  }
}

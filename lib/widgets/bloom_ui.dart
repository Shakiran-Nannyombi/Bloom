import 'package:flutter/material.dart';

import '../theme/bloom_colors.dart';
import 'layout.dart';

class BloomScopeWidth extends StatelessWidget {
  const BloomScopeWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BloomPage(child: child);
  }
}

class BloomCard extends StatelessWidget {
  const BloomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: BloomColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: BloomColors.outlineVariant.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: BloomColors.primary.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: card,
      ),
    );
  }
}

class LanguagePill extends StatelessWidget {
  const LanguagePill({
    super.key,
    required this.isLuganda,
    required this.onEnglish,
    required this.onLuganda,
    required this.englishLabel,
    required this.lugandaLabel,
  });

  final bool isLuganda;
  final VoidCallback onEnglish;
  final VoidCallback onLuganda;
  final String englishLabel;
  final String lugandaLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: BloomColors.surfaceHigh,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _chip(englishLabel, !isLuganda, onEnglish),
          _chip(lugandaLabel, isLuganda, onLuganda),
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? BloomColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : BloomColors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class BloomPrimaryButton extends StatelessWidget {
  const BloomPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton.icon(
      onPressed: onPressed,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 20),
      label: Text(label),
    );
    if (!expand) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

class CheckLine extends StatelessWidget {
  const CheckLine({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: BloomColors.secondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: BloomColors.onSurfaceVariant,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class SegmentedProgress extends StatelessWidget {
  const SegmentedProgress({
    super.key,
    required this.total,
    required this.current,
  });

  final int total;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final filled = i < current;
        final isCurrent = i == current - 1;
        return Expanded(
          child: Container(
            height: 8,
            margin: EdgeInsets.only(right: i == total - 1 ? 0 : 4),
            decoration: BoxDecoration(
              color: filled ? BloomColors.primary : BloomColors.surfaceHigh,
              borderRadius: BorderRadius.horizontal(
                left: i == 0 ? const Radius.circular(99) : Radius.zero,
                right: i == total - 1 ? const Radius.circular(99) : Radius.zero,
              ),
              border: isCurrent
                  ? Border.all(color: BloomColors.secondary, width: 1.5)
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

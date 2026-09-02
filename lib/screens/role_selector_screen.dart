import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';


class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);

    return Scaffold(
      body: SafeArea(
        child: BloomScopeWidth(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
                  children: [
                    Text(
                      s.appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s.tagline,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: BloomColors.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: LanguagePill(
                        isLuganda: state.isLuganda,
                        englishLabel: s.english,
                        lugandaLabel: s.luganda,
                        onEnglish: () =>
                            state.setLanguage(AppLanguage.english),
                        onLuganda: () =>
                            state.setLanguage(AppLanguage.luganda),
                      ),
                    ),
                    const SizedBox(height: 28),
                    _ModeCard(
                      icon: Icons.school,
                      iconBg: BloomColors.primaryContainer,
                      iconColor: BloomColors.onPrimaryContainer,
                      title: s.teacherMode,
                      features: [s.teacherFeat1, s.teacherFeat2, s.teacherFeat3],
                      cta: s.enterMode,
                      onEnter: () {
                        state.selectRole(UserRole.teacher);
                        context.go('/home');
                      },
                    ),
                    const SizedBox(height: 16),
                    _ModeCard(
                      icon: Icons.family_restroom,
                      iconBg: BloomColors.secondaryContainer,
                      iconColor: BloomColors.onSecondaryContainer,
                      title: s.parentMode,
                      features: [s.parentFeat1, s.parentFeat2, s.parentFeat3],
                      cta: s.enterMode,
                      onEnter: () {
                        state.selectRole(UserRole.parent);
                        context.go('/home');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.copyright,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: BloomColors.onSurfaceVariant,
                            ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: BloomColors.tertiary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.cloud_done,
                            size: 14,
                            color: BloomColors.tertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            s.offlineReady,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: BloomColors.tertiary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.features,
    required this.cta,
    required this.onEnter,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final List<String> features;
  final String cta;
  final VoidCallback onEnter;

  @override
  Widget build(BuildContext context) {
    return BloomCard(
      onTap: onEnter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconBg,
                foregroundColor: iconColor,
                child: Icon(icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: BloomColors.primary,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final f in features) CheckLine(text: f),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: BloomColors.surfaceHigh,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    cta,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: BloomColors.primary,
                        ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward, size: 16, color: BloomColors.primary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

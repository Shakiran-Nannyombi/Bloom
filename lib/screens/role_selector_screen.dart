import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_logo.dart';
import '../widgets/bloom_ui.dart';
import '../widgets/layout.dart';

class RoleSelectorScreen extends StatelessWidget {
  const RoleSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final wide = isWideLayout(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: wide ? 48 : 20, vertical: 16),
            decoration: const BoxDecoration(
              color: BloomColors.surface,
              border: Border(
                bottom: BorderSide(color: BloomColors.outlineVariant, width: 0.8),
              ),
            ),
            child: Row(
              children: [
                const BloomLogo(size: 40, showWordmark: true),
                const Spacer(),
                LanguagePill(
                  isLuganda: state.isLuganda,
                  englishLabel: s.english,
                  lugandaLabel: s.luganda,
                  onEnglish: () => state.setLanguage(AppLanguage.english),
                  onLuganda: () => state.setLanguage(AppLanguage.luganda),
                ),
              ],
            ),
          ),
          Expanded(
            child: BloomPage(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroBanner(strings: s, wide: wide),
                    const SizedBox(height: 28),
                    if (wide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _ModeCard(
                              icon: Icons.school,
                              iconBg: BloomColors.primaryContainer,
                              iconColor: BloomColors.onPrimaryContainer,
                              title: s.teacherMode,
                              features: [
                                s.teacherFeat1,
                                s.teacherFeat2,
                                s.teacherFeat3,
                              ],
                              cta: s.enterMode,
                              onEnter: () {
                                state.selectRole(UserRole.teacher);
                                context.go('/home');
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _ModeCard(
                              icon: Icons.family_restroom,
                              iconBg: BloomColors.secondaryContainer,
                              iconColor: BloomColors.onSecondaryContainer,
                              title: s.parentMode,
                              features: [
                                s.parentFeat1,
                                s.parentFeat2,
                                s.parentFeat3,
                              ],
                              cta: s.enterMode,
                              onEnter: () {
                                state.selectRole(UserRole.parent);
                                context.go('/home');
                              },
                            ),
                          ),
                        ],
                      )
                    else ...[
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
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        s.copyright,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: BloomColors.onSurfaceVariant,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        s.offlineReady,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: BloomColors.tertiary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.strings, required this.wide});

  final BloomStrings strings;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/hero.png',
        fit: BoxFit.cover,
        alignment: Alignment.centerLeft,
        height: wide ? 420 : 220,
        width: double.infinity,
      ),
    );

    if (!wide) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image,
          const SizedBox(height: 20),
          _HeroCopy(strings: strings),
        ],
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 420,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/hero.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    BloomColors.card.withValues(alpha: 0.55),
                    BloomColors.card.withValues(alpha: 0.96),
                  ],
                  stops: const [0.38, 0.62, 0.82],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 40, 32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: _HeroCopy(strings: strings),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.strings});
  final BloomStrings strings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BloomLogo(size: 72),
        const SizedBox(height: 20),
        Text(
          strings.tagline,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(height: 12),
        Text(
          strings.aboutBody,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: BloomColors.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          strings.learnTalkGuide,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: BloomColors.primary,
              ),
        ),
      ],
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
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: onEnter,
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: Text(cta),
            ),
          ),
        ],
      ),
    );
  }
}

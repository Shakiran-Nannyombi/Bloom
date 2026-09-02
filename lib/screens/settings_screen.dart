import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';
import '../widgets/layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);

    return BloomPage(
      child: ListView(
        children: [
          Text(s.settings, style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 20),
          BloomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.languageLabel, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 12),
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
          const SizedBox(height: 12),
          BloomCard(
            onTap: () {
              state.clearRole();
              context.go('/');
            },
            child: Row(
              children: [
                const Icon(Icons.swap_horiz, color: BloomColors.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${s.switchRole} — ${state.isTeacher ? s.teacherMode : s.parentMode}',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          BloomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.activity, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                if (state.referrals.isEmpty && state.reports.isEmpty)
                  Text(s.noActivity, style: Theme.of(context).textTheme.bodySmall)
                else ...[
                  Text(s.savedReferrals, style: Theme.of(context).textTheme.labelLarge),
                  for (final r in state.referrals)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text('• ${r.mentorName} — ${r.focus}'),
                    ),
                  const SizedBox(height: 12),
                  Text(s.savedReports, style: Theme.of(context).textTheme.labelLarge),
                  for (final r in state.reports)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text('• ${r.note}'),
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          BloomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.aboutBloom, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(s.aboutBody, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 12),
                Text(
                  s.learnTalkGuide,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: BloomColors.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

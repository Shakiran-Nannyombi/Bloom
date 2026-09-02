import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/content.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final module = bloomModules.first;
    final isTeacher = state.isTeacher;
    final name = isTeacher ? 'Namuli' : 'Nakato';

    return SafeArea(
      child: BloomScopeWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            Row(
              children: [
                Text(
                  s.appName,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Spacer(),
                IconButton(
                  tooltip: s.offlineReady,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(s.allSynced)),
                    );
                  },
                  icon: const Icon(Icons.sync, color: BloomColors.primary),
                ),
                IconButton(
                  tooltip: s.languageLabel,
                  onPressed: state.toggleLanguage,
                  icon: const Icon(Icons.language, color: BloomColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              isTeacher ? s.teacherHello(name) : s.parentHello(name),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.cloud_done, size: 16, color: BloomColors.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(s.allSynced, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 20),
            BloomCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: BloomColors.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          s.activeModule,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: BloomColors.onPrimaryContainer,
                              ),
                        ),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        backgroundColor: BloomColors.surfaceContainer,
                        foregroundColor: BloomColors.primary,
                        child: Icon(Icons.menu_book),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    module.title.of(state.language),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        s.stepOf(module.currentStep, module.totalSteps),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      const Spacer(),
                      Text(
                        s.percentComplete(module.progress),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SegmentedProgress(
                    total: module.totalSteps,
                    current: module.currentStep,
                  ),
                  const SizedBox(height: 16),
                  BloomPrimaryButton(
                    label: isTeacher ? s.resumeSession : s.learnBefore,
                    icon: Icons.play_arrow,
                    onPressed: () => isTeacher
                        ? context.push('/session/${module.id}')
                        : context.push('/modules/${module.id}'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.15,
              children: [
                _ActionTile(
                  icon: Icons.play_circle_outline,
                  label: isTeacher ? s.startSession : s.startConversation,
                  color: BloomColors.primary,
                  onTap: () => isTeacher
                      ? context.push('/session/${module.id}')
                      : context.push('/modules/${module.id}'),
                ),
                _ActionTile(
                  icon: Icons.smart_toy_outlined,
                  label: s.askAi,
                  color: BloomColors.secondary,
                  onTap: () => context.go('/ai'),
                ),
                _ActionTile(
                  icon: Icons.how_to_reg_outlined,
                  label: s.referMentor,
                  color: BloomColors.onSurfaceVariant,
                  onTap: () => context.push('/refer'),
                ),
                _ActionTile(
                  icon: Icons.report_problem_outlined,
                  label: s.reportConcern,
                  color: BloomColors.error,
                  onTap: () => context.push('/report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BloomCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

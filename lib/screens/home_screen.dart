import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/content.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';
import '../widgets/layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final module = bloomModules.first;
    final isTeacher = state.isTeacher;
    final wide = isWideLayout(context);
    final percent = state.percentFor(module.id, module.totalSteps);
    final step = state.talkingPointFor(module.id) + 1;

    final hero = BloomCard(
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
              const Icon(Icons.menu_book, color: BloomColors.primary),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            module.title.of(state.language),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            module.summary.of(state.language),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: BloomColors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                s.stepOf(step.clamp(1, module.totalSteps), module.totalSteps),
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const Spacer(),
              Text(
                s.percentComplete(percent),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          SegmentedProgress(
            total: module.totalSteps,
            current: step.clamp(1, module.totalSteps),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              BloomPrimaryButton(
                label: isTeacher ? s.resumeSession : s.learnBefore,
                icon: Icons.play_arrow,
                onPressed: () => isTeacher
                    ? context.push('/session/${module.id}')
                    : context.push('/modules/${module.id}'),
              ),
              OutlinedButton.icon(
                onPressed: () => context.push('/modules/${module.id}'),
                icon: const Icon(Icons.menu_book_outlined),
                label: Text(s.openLearn),
              ),
            ],
          ),
        ],
      ),
    );

    final actions = [
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
    ];

    return BloomPage(
      child: ListView(
        children: [
          Text(
            isTeacher ? s.teacherHello(state.userName) : s.parentHello(state.userName),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          Text(
            isTeacher ? s.overview : s.parentOverview,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: BloomColors.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 28),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: hero),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.35,
                    children: actions,
                  ),
                ),
              ],
            )
          else ...[
            hero,
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: actions,
            ),
          ],
        ],
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
          const SizedBox(height: 16),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

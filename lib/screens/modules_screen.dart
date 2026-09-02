import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/content.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';

class ModulesScreen extends StatelessWidget {
  const ModulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);

    return SafeArea(
      child: BloomScopeWidth(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            Text(s.modules, style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(height: 8),
            Text(
              state.isTeacher ? s.modulesIntroTeacher : s.modulesIntroParent,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: BloomColors.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 20),
            for (final module in bloomModules) ...[
              BloomCard(
                onTap: () => context.push('/modules/${module.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            module.title.of(state.language),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        if (state.reviewedModules.contains(module.id))
                          const Icon(Icons.check_circle, color: BloomColors.tertiary),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      module.summary.of(state.language),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: module.progress / 100,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(99),
                      color: BloomColors.primary,
                      backgroundColor: BloomColors.surfaceHigh,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s.percentComplete(module.progress),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

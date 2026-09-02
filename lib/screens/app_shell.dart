import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_logo.dart';
import '../widgets/bloom_ui.dart';
import '../widgets/layout.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  int _indexFor(String location) {
    if (location.startsWith('/modules')) return 1;
    if (location.startsWith('/ai')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  void _go(BuildContext context, int i) {
    switch (i) {
      case 0:
        context.go('/home');
      case 1:
        context.go('/modules');
      case 2:
        context.go('/ai');
      case 3:
        context.go('/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final location = GoRouterState.of(context).uri.path;
    final index = _indexFor(location);
    final wide = isWideLayout(context);

    final destinations = [
      (Icons.dashboard_outlined, Icons.dashboard, s.dashboard),
      (Icons.menu_book_outlined, Icons.menu_book, s.modules),
      (Icons.smart_toy_outlined, Icons.smart_toy, s.aiAssist),
      (Icons.settings_outlined, Icons.settings, s.settings),
    ];

    return Scaffold(
      body: Column(
        children: [
          Material(
            color: BloomColors.surface,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: BloomColors.outlineVariant, width: 0.8),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 28 : 16,
                vertical: 10,
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const BloomLogo(size: 36, showWordmark: true),
                        if (wide) ...[
                          const SizedBox(width: 28),
                          for (var i = 0; i < destinations.length; i++)
                            _TopNavLink(
                              label: destinations[i].$3,
                              icon: index == i
                                  ? destinations[i].$2
                                  : destinations[i].$1,
                              selected: index == i,
                              onTap: () => _go(context, i),
                            ),
                        ],
                        const Spacer(),
                        LanguagePill(
                          isLuganda: state.isLuganda,
                          englishLabel: s.english,
                          lugandaLabel: s.luganda,
                          onEnglish: () =>
                              state.setLanguage(AppLanguage.english),
                          onLuganda: () =>
                              state.setLanguage(AppLanguage.luganda),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          tooltip: state.syncing ? s.syncing : s.lastSyncedAgo,
                          onPressed: state.syncNow,
                          icon: Icon(
                            state.syncing ? Icons.sync : Icons.cloud_done,
                            color: BloomColors.tertiary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: BloomColors.primaryContainer,
                          foregroundColor: Colors.white,
                          child: Text(
                            state.userName[0],
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    if (!wide) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: destinations.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 8),
                          itemBuilder: (context, i) {
                            return _TopNavLink(
                              label: destinations[i].$3,
                              icon: index == i
                                  ? destinations[i].$2
                                  : destinations[i].$1,
                              selected: index == i,
                              onTap: () => _go(context, i),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _TopNavLink extends StatelessWidget {
  const _TopNavLink({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor:
              selected ? BloomColors.onPrimary : BloomColors.onSurfaceVariant,
          backgroundColor: selected ? BloomColors.primary : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        icon: Icon(icon, size: 18),
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: selected ? BloomColors.onPrimary : BloomColors.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

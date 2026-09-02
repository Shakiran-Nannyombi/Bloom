import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../data/content.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';

class LearnModuleScreen extends StatefulWidget {
  const LearnModuleScreen({super.key, required this.moduleId});

  final String moduleId;

  @override
  State<LearnModuleScreen> createState() => _LearnModuleScreenState();
}

class _LearnModuleScreenState extends State<LearnModuleScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final module = moduleById(widget.moduleId);
    final reviewed = state.reviewedModules.contains(module.id);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: Row(
          children: [
            const SizedBox(width: 0),
            Expanded(
              child: Text(
                module.title.of(state.language),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: state.toggleLanguage,
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: BloomScopeWidth(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu_book, size: 16, color: BloomColors.secondary),
                      const SizedBox(width: 6),
                      Text(
                        s.learnBefore.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: BloomColors.secondary,
                              letterSpacing: 1.1,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    module.title.of(state.language),
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    s.learnIntro,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: BloomColors.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabs,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: BloomColors.primary,
              unselectedLabelColor: BloomColors.onSurfaceVariant,
              indicatorColor: BloomColors.primary,
              tabs: [
                Tab(text: s.whatToKnow),
                Tab(text: s.commonQuestions),
                Tab(text: s.conversationStarters),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [
                  _FactsTab(module: module, language: state.language, strings: s),
                  _QuestionsTab(module: module, language: state.language, strings: s),
                  _StartersTab(module: module, language: state.language),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: BloomPrimaryButton(
                      expand: true,
                      label: reviewed ? s.continueSession : s.markReviewed,
                      icon: reviewed ? Icons.play_arrow : Icons.check_circle,
                      onPressed: () {
                        if (!reviewed) {
                          state.markReviewed(module.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(s.markedReviewed)),
                          );
                        } else {
                          context.push('/session/${module.id}');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FactsTab extends StatelessWidget {
  const _FactsTab({
    required this.module,
    required this.language,
    required this.strings,
  });

  final BloomModule module;
  final AppLanguage language;
  final BloomStrings strings;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      children: [
        for (final fact in module.facts) ...[
          BloomCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BloomColors.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.front_hand, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fact.title.of(language),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fact.body.of(language),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        Text(
          strings.anticipatedQuestions.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: BloomColors.secondary,
                letterSpacing: 0.8,
              ),
        ),
        const SizedBox(height: 8),
        for (final qa in module.anticipated)
          _QaTile(item: qa, language: language),
      ],
    );
  }
}

class _QuestionsTab extends StatelessWidget {
  const _QuestionsTab({
    required this.module,
    required this.language,
    required this.strings,
  });

  final BloomModule module;
  final AppLanguage language;
  final BloomStrings strings;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      children: [
        Text(
          strings.commonQuestions,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        for (final qa in module.anticipated) _QaTile(item: qa, language: language),
      ],
    );
  }
}

class _StartersTab extends StatelessWidget {
  const _StartersTab({required this.module, required this.language});

  final BloomModule module;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      children: [
        for (final line in module.starters) ...[
          BloomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.of(language),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: BloomColors.primary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: line.of(language)));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(BloomStrings(language).copied)),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy, size: 16),
                    label: Text(BloomStrings(language).copy),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _QaTile extends StatelessWidget {
  const _QaTile({required this.item, required this.language});

  final QaItem item;
  final AppLanguage language;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: BloomColors.outlineVariant.withValues(alpha: 0.5)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: BloomColors.outlineVariant.withValues(alpha: 0.5)),
          ),
          title: Text(
            item.question.of(language),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            Text(
              item.answer.of(language),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

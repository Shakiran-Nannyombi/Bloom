import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/content.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';
import '../widgets/layout.dart';

class ReferMentorScreen extends StatelessWidget {
  const ReferMentorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);

    return SubpageScaffold(
      title: s.referMentor,
      body: BloomPage(
        child: ListView(
          children: [
            Text(s.mentorsTitle, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(s.mentorsBody, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            for (final mentor in mentors) ...[
              BloomCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mentor.name, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Text(mentor.focus.of(state.language)),
                    Text(
                      mentor.location.of(state.language),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FilledButton(
                        onPressed: () {
                          state.addReferral(
                            mentor.name,
                            mentor.focus.of(state.language),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(s.connected)),
                          );
                        },
                        child: Text(s.connect),
                      ),
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

class ReportConcernScreen extends StatefulWidget {
  const ReportConcernScreen({super.key});

  @override
  State<ReportConcernScreen> createState() => _ReportConcernScreenState();
}

class _ReportConcernScreenState extends State<ReportConcernScreen> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);

    return SubpageScaffold(
      title: s.reportConcern,
      body: BloomPage(
        child: ListView(
          children: [
            Text(s.reportTitle, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(s.reportBody, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            BloomCard(
              child: Row(
                children: [
                  const Icon(Icons.phone_in_talk, color: BloomColors.error),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      s.helpline,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _note,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: s.concernHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: BloomColors.outlineVariant),
                ),
              ),
            ),
            const SizedBox(height: 16),
            BloomPrimaryButton(
              label: s.submitReport,
              onPressed: () {
                final note = _note.text.trim();
                if (note.isEmpty) return;
                state.addReport(note);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(s.reportSent)),
                );
                context.go('/settings');
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../data/bloom_ai.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';
import '../widgets/layout.dart';

class AiAssistScreen extends StatefulWidget {
  const AiAssistScreen({super.key});

  @override
  State<AiAssistScreen> createState() => _AiAssistScreenState();
}

class _AiAssistScreenState extends State<AiAssistScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _ask(BloomAppState state, String text) {
    final q = text.trim();
    if (q.isEmpty) return;
    final reply = replyAsBloomAi(q, state.language);
    state.addMessage(ChatMessage(text: q, fromAi: false));
    state.addMessage(
      ChatMessage(text: reply.text, fromAi: true, isSafety: reply.isSafety),
    );
    _input.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final prompts = state.isTeacher
        ? [
            'How do I explain menstruation simply to my class?',
            'How do I explain this in the local language?',
            'A student asked if blood means she is sick.',
          ]
        : [
            'How do I start a conversation about body safety with my daughter?',
            'Give me a Luganda opener I can say tonight.',
            'Is it rude if she says no to a hug?',
          ];

    return BloomPage(
      fill: true,
      child: Column(
        children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.aiTitle, style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 6),
                  Text(s.aiDisclaimer, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Expanded(
              child: state.aiMessages.isEmpty
                  ? ListView(
                      children: [
                        Text(
                          s.suggested,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: BloomColors.secondary,
                              ),
                        ),
                        const SizedBox(height: 12),
                        for (final p in prompts)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: BloomCard(
                              onTap: () => _ask(state, p),
                              padding: const EdgeInsets.all(16),
                              child: Text(p),
                            ),
                          ),
                      ],
                    )
                  : ListView.builder(
                      controller: _scroll,
                      padding: const EdgeInsets.only(bottom: 8),
                      itemCount: state.aiMessages.length,
                      itemBuilder: (context, i) {
                        final m = state.aiMessages[i];
                        final align =
                            m.fromAi ? Alignment.centerLeft : Alignment.centerRight;
                        final bg = m.fromAi
                            ? (m.isSafety
                                ? BloomColors.errorContainer
                                : BloomColors.card)
                            : BloomColors.surfaceHigh;
                        return Align(
                          alignment: align,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            constraints: const BoxConstraints(maxWidth: 520),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: BloomColors.outlineVariant.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (m.fromAi)
                                  Text(
                                    s.bloomAi,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                Text(m.text),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _input,
                textInputAction: TextInputAction.send,
                onSubmitted: (v) => _ask(state, v),
                decoration: InputDecoration(
                  hintText: state.isTeacher ? s.askTips : s.askParentTips,
                  suffixIcon: IconButton(
                    onPressed: () => _ask(state, _input.text),
                    icon: const Icon(Icons.send, color: BloomColors.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

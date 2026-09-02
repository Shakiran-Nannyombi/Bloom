import 'package:flutter/material.dart';

import '../data/bloom_ai.dart';
import '../data/content.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';
import '../widgets/layout.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key, required this.moduleId});

  final String moduleId;

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _send(BloomAppState state) {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    final reply = replyAsBloomAi(text, state.language);
    state.addMessage(ChatMessage(text: text, fromAi: false));
    state.addMessage(
      ChatMessage(text: reply.text, fromAi: true, isSafety: reply.isSafety),
    );
    _input.clear();
  }

  void _setIndex(BloomAppState state, int index, int max) {
    state.setTalkingPoint(widget.moduleId, index.clamp(0, max));
  }

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final module = moduleById(widget.moduleId);
    final points = module.talkingPoints;
    final index = state.talkingPointFor(widget.moduleId).clamp(0, points.length - 1);
    final point = points[index];
    final tipLabel = state.isTeacher ? s.teacherTip : s.parentTip;
    final wide = isWideLayout(context);

    final lesson = ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: BloomColors.surfaceLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: BloomColors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.record_voice_over, color: BloomColors.primary),
              const SizedBox(width: 8),
              Text(
                '${s.talkingPoint} ${index + 1} / ${points.length}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              SizedBox(
                width: 140,
                child: SegmentedProgress(
                  total: points.length,
                  current: index + 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        BloomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                point.title.of(state.language),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                point.script.of(state.language),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: BloomColors.surface,
                  border: Border(
                    left: BorderSide(color: BloomColors.secondary, width: 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tipLabel,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: BloomColors.secondary,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      point.tip.of(state.language),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: BloomColors.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '${s.visualAid}\n${point.visual.of(state.language)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: index == 0
                  ? null
                  : () => _setIndex(state, index - 1, points.length - 1),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: Text(s.previousPoint),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: index >= points.length - 1
                  ? null
                  : () => _setIndex(state, index + 1, points.length - 1),
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: Text(s.nextPoint),
            ),
          ],
        ),
      ],
    );

                final copilot = _CopilotPanel(
      strings: s,
      messages: state.aiMessages,
      controller: _input,
      onSend: () => _send(state),
      fillHeight: wide,
    );

    return SubpageScaffold(
      title: module.title.of(state.language),
      actions: [
        IconButton(
          onPressed: state.toggleLanguage,
          icon: const Icon(Icons.language),
        ),
      ],
      body: wide
          ? Row(
              children: [
                Expanded(
                  child: BloomPage(child: lesson),
                ),
                Container(
                  width: 400,
                  decoration: const BoxDecoration(
                    color: BloomColors.surface,
                    border: Border(
                      left: BorderSide(color: BloomColors.outlineVariant),
                    ),
                  ),
                  child: copilot,
                ),
              ],
            )
          : Column(
              children: [
                Expanded(child: BloomPage(child: lesson)),
                copilot,
              ],
            ),
    );
  }
}

class _CopilotPanel extends StatelessWidget {
  const _CopilotPanel({
    required this.strings,
    required this.messages,
    required this.controller,
    required this.onSend,
    required this.fillHeight,
  });

  final BloomStrings strings;
  final List<ChatMessage> messages;
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool fillHeight;

  @override
  Widget build(BuildContext context) {
    final lastAi = messages.where((m) => m.fromAi).lastOrNull;
    final state = BloomScope.of(context);
    final replyBox = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lastAi?.isSafety == true
            ? BloomColors.errorContainer
            : BloomColors.surfaceLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        lastAi?.text ??
            (state.isTeacher
                ? 'Try: “How do I explain this in the local language?”'
                : 'Try: “How do I start a conversation about body safety?”'),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );

    final body = Column(
      mainAxisSize: fillHeight ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: BloomColors.secondaryContainer,
              foregroundColor: BloomColors.onSecondaryContainer,
              child: Icon(Icons.psychology, size: 18),
            ),
            const SizedBox(width: 8),
            Text(strings.aiTitle, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        const SizedBox(height: 8),
        Text(strings.aiDisclaimer, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 12),
        if (fillHeight)
          Expanded(child: replyBox)
        else
          replyBox,
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          textInputAction: TextInputAction.send,
          onSubmitted: (_) => onSend(),
          decoration: InputDecoration(
            hintText: state.isTeacher ? strings.askTips : strings.askParentTips,
            suffixIcon: IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send, color: BloomColors.primary),
            ),
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: body,
    );
  }
}

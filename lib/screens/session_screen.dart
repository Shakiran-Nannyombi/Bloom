import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/bloom_ai.dart';
import '../data/content.dart';
import '../l10n/bloom_strings.dart';
import '../state/app_state.dart';
import '../theme/bloom_colors.dart';
import '../widgets/bloom_ui.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key, required this.moduleId});

  final String moduleId;

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final _input = TextEditingController();
  int _index = 0;
  final _localChat = <ChatMessage>[];

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _send(BloomAppState state) {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    final reply = replyAsBloomAi(text, state.language);
    setState(() {
      _localChat
        ..add(ChatMessage(text: text, fromAi: false))
        ..add(ChatMessage(text: reply.text, fromAi: true, isSafety: reply.isSafety));
      _input.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = BloomScope.of(context);
    final s = BloomStrings(state.language);
    final module = moduleById(widget.moduleId);
    final points = module.talkingPoints;
    final point = points[_index.clamp(0, points.length - 1)];
    final tipLabel = state.isTeacher ? s.teacherTip : s.parentTip;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Column(
          children: [
            Text(
              module.title.of(state.language),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: BloomColors.primary,
                    fontSize: 16,
                  ),
            ),
            Text(
              state.isTeacher ? s.teacherMode : s.parentMode,
              style: Theme.of(context).textTheme.labelSmall,
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
      body: Column(
        children: [
          Expanded(
            child: BloomScopeWidth(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
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
                          '${s.talkingPoint} ${_index + 1} / ${points.length}',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 120,
                          child: SegmentedProgress(
                            total: points.length,
                            current: _index + 1,
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
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          point.script.of(state.language),
                          style: Theme.of(context).textTheme.bodyMedium,
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
                              Row(
                                children: [
                                  const Icon(
                                    Icons.tips_and_updates,
                                    size: 16,
                                    color: BloomColors.secondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    tipLabel,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: BloomColors.secondary,
                                        ),
                                  ),
                                ],
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
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: BloomColors.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.bottomLeft,
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
                      TextButton.icon(
                        onPressed: _index == 0
                            ? null
                            : () => setState(() => _index -= 1),
                        icon: const Icon(Icons.arrow_back_ios, size: 14),
                        label: Text(s.previousPoint),
                      ),
                      const Spacer(),
                      FilledButton.icon(
                        onPressed: _index >= points.length - 1
                            ? null
                            : () => setState(() => _index += 1),
                        icon: const Icon(Icons.arrow_forward_ios, size: 14),
                        label: Text(s.nextPoint),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _CopilotDrawer(
            strings: s,
            messages: _localChat,
            controller: _input,
            onSend: () => _send(state),
          ),
        ],
      ),
    );
  }
}

class _CopilotDrawer extends StatelessWidget {
  const _CopilotDrawer({
    required this.strings,
    required this.messages,
    required this.controller,
    required this.onSend,
  });

  final BloomStrings strings;
  final List<ChatMessage> messages;
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final lastAi = messages.where((m) => m.fromAi).lastOrNull;

    return Material(
      color: BloomColors.surface,
      elevation: 12,
      shadowColor: BloomColors.primary.withValues(alpha: 0.08),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: BloomColors.outlineVariant,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: lastAi?.isSafety == true
                    ? BloomColors.errorContainer
                    : BloomColors.surfaceLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: BloomColors.secondaryContainer,
                    foregroundColor: BloomColors.onSecondaryContainer,
                    child: const Icon(Icons.psychology, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${strings.aiTitle}: ',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: lastAi?.text ??
                                (BloomScope.of(context).isTeacher
                                    ? 'I can help you adjust this explanation. Try asking: “How do I explain this in the local language?”'
                                    : 'I can help you start this conversation. Try asking: “How do I start a conversation about body safety?”'),
                          ),
                        ],
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: BloomScope.of(context).isTeacher
                    ? strings.askTips
                    : strings.askParentTips,
                suffixIcon: IconButton(
                  onPressed: onSend,
                  icon: const CircleAvatar(
                    radius: 14,
                    backgroundColor: BloomColors.primary,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.send, size: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

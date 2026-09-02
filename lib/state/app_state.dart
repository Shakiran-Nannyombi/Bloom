import 'package:flutter/material.dart';

enum UserRole { teacher, parent }

enum AppLanguage { english, luganda }

class BloomAppState extends ChangeNotifier {
  UserRole? role;
  AppLanguage language = AppLanguage.english;
  int talkingPointIndex = 0;
  final Set<String> reviewedModules = {};
  final List<ChatMessage> aiMessages = [];

  bool get isLuganda => language == AppLanguage.luganda;
  bool get isTeacher => role == UserRole.teacher;

  void selectRole(UserRole value) {
    role = value;
    notifyListeners();
  }

  void clearRole() {
    role = null;
    notifyListeners();
  }

  void setLanguage(AppLanguage value) {
    language = value;
    notifyListeners();
  }

  void toggleLanguage() {
    language = isLuganda ? AppLanguage.english : AppLanguage.luganda;
    notifyListeners();
  }

  void markReviewed(String moduleId) {
    reviewedModules.add(moduleId);
    notifyListeners();
  }

  void setTalkingPoint(int index) {
    talkingPointIndex = index;
    notifyListeners();
  }

  void addMessage(ChatMessage message) {
    aiMessages.add(message);
    notifyListeners();
  }

  void resetChat() {
    aiMessages.clear();
    notifyListeners();
  }
}

class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.fromAi,
    this.isSafety = false,
  });

  final String text;
  final bool fromAi;
  final bool isSafety;
}

class BloomScope extends InheritedNotifier<BloomAppState> {
  const BloomScope({
    super.key,
    required BloomAppState super.notifier,
    required super.child,
  });

  static BloomAppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<BloomScope>();
    assert(scope != null, 'BloomScope missing');
    return scope!.notifier!;
  }
}

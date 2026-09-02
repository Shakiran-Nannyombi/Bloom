import 'package:flutter/material.dart';

enum UserRole { teacher, parent }

enum AppLanguage { english, luganda }

class ReferralRecord {
  ReferralRecord({
    required this.mentorName,
    required this.focus,
    required this.at,
  });
  final String mentorName;
  final String focus;
  final DateTime at;
}

class SafetyReport {
  SafetyReport({required this.note, required this.at});
  final String note;
  final DateTime at;
}

class BloomAppState extends ChangeNotifier {
  UserRole? role;
  AppLanguage language = AppLanguage.english;
  final Set<String> reviewedModules = {};
  final Map<String, int> sessionIndex = {};
  final List<ChatMessage> aiMessages = [];
  final List<ReferralRecord> referrals = [];
  final List<SafetyReport> reports = [];
  bool syncing = false;
  DateTime lastSynced = DateTime.now();

  bool get isLuganda => language == AppLanguage.luganda;
  bool get isTeacher => role == UserRole.teacher;
  String get userName => isTeacher ? 'Namuli' : 'Nakato';

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

  int talkingPointFor(String moduleId) => sessionIndex[moduleId] ?? 0;

  void setTalkingPoint(String moduleId, int index) {
    sessionIndex[moduleId] = index;
    notifyListeners();
  }

  int percentFor(String moduleId, int totalSteps) {
    if (totalSteps <= 0) return 0;
    if (reviewedModules.contains(moduleId)) {
      final i = talkingPointFor(moduleId) + 1;
      return ((i / totalSteps) * 100).clamp(10, 100).round();
    }
    final i = talkingPointFor(moduleId);
    if (i == 0) return 0;
    return ((i + 1) / totalSteps * 100).round();
  }

  void addMessage(ChatMessage message) {
    aiMessages.add(message);
    notifyListeners();
  }

  void resetChat() {
    aiMessages.clear();
    notifyListeners();
  }

  void addReferral(String mentorName, String focus) {
    referrals.insert(
      0,
      ReferralRecord(mentorName: mentorName, focus: focus, at: DateTime.now()),
    );
    notifyListeners();
  }

  void addReport(String note) {
    reports.insert(0, SafetyReport(note: note, at: DateTime.now()));
    notifyListeners();
  }

  Future<void> syncNow() async {
    if (syncing) return;
    syncing = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    lastSynced = DateTime.now();
    syncing = false;
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

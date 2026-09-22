import 'package:flutter/foundation.dart';

/// Stats / charts screen state.
class StatsNotifier extends ChangeNotifier {
  // Placeholder values — wire to TasksNotifier later in class.
  int completedCount = 0;
  int pendingCount = 0;

  void updateCounts({required int completed, required int pending}) {
    completedCount = completed;
    pendingCount = pending;
    notifyListeners();
  }
}

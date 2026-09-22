import 'package:flutter/foundation.dart';
import 'package:todo_class/models/todo_model.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';

/// Holds task list state and syncs it to SharedPreferences.
/// Shared singleton so every screen reads/writes the same list.
class TasksNotifier extends ChangeNotifier {
  TasksNotifier._();

  static final TasksNotifier instance = TasksNotifier._();

  final List<TodoModel> _tasks = [];
  bool _isLoaded = false;

  List<TodoModel> get tasks => List.unmodifiable(_tasks);

  bool get isLoaded => _isLoaded;

  List<TodoModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  List<TodoModel> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  TodoModel? findById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Call once at app start (after LocalStorageService.init).
  Future<void> load() async {
    final saved = await LocalStorageService.instance.loadTasks();
    _tasks
      ..clear()
      ..addAll(saved);
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _persist() async {
    await LocalStorageService.instance.saveTasks(_tasks);
  }

  Future<void> addTask({
    required String title,
    String description = '',
    DateTime? dueDate,
  }) async {
    final task = TodoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      dueDate: dueDate,
      createdAt: DateTime.now(),
    );
    _tasks.insert(0, task);
    notifyListeners();
    await _persist();
  }

  Future<void> updateTask(TodoModel updated) async {
    final index = _tasks.indexWhere((task) => task.id == updated.id);
    if (index == -1) return;
    _tasks[index] = updated;
    notifyListeners();
    await _persist();
  }

  Future<void> toggleComplete(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index == -1) return;
    final task = _tasks[index];
    _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
    notifyListeners();
    await _persist();
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    await _persist();
  }

  Future<void> clearCompleted() async {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
    await _persist();
  }
}

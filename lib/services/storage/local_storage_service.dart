import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_class/models/todo_model.dart';
import 'package:todo_class/services/storage/storage_keys.dart';

/// Key-value storage wrapper (SharedPreferences).
/// Use this in lessons instead of calling SharedPreferences directly from UI.
class LocalStorageService {
  LocalStorageService._();

  static final LocalStorageService instance = LocalStorageService._();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get _requirePrefs {
    final prefs = _prefs;
    if (prefs == null) {
      throw StateError(
        'LocalStorageService not initialized. Call init() in main().',
      );
    }
    return prefs;
  }

  // --- Onboarding ---

  Future<bool> getOnboardingDone() async {
    await init();
    return _requirePrefs.getBool(StorageKeys.onboardingDone) ?? false;
  }

  Future<void> setOnboardingDone(bool value) async {
    await init();
    await _requirePrefs.setBool(StorageKeys.onboardingDone, value);
  }

  // --- Auth helpers (for splash / login lessons) ---

  Future<bool> getIsLoggedIn() async {
    await init();
    return _requirePrefs.getBool(StorageKeys.isLoggedIn) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    await init();
    await _requirePrefs.setBool(StorageKeys.isLoggedIn, value);
  }

  Future<String?> getUserName() async {
    await init();
    return _requirePrefs.getString(StorageKeys.userName);
  }

  Future<void> setUserName(String name) async {
    await init();
    await _requirePrefs.setString(StorageKeys.userName, name);
  }

  Future<void> clearSession() async {
    await init();
    await _requirePrefs.remove(StorageKeys.isLoggedIn);
    await _requirePrefs.remove(StorageKeys.userName);
    await _requirePrefs.remove(StorageKeys.userEmail);
  }

  // --- Tasks (list → JSON string → SharedPreferences) ---

  Future<void> saveTasks(List<TodoModel> tasks) async {
    await init();
    final encoded = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await _requirePrefs.setString(StorageKeys.tasksJson, encoded);
  }

  Future<List<TodoModel>> loadTasks() async {
    await init();
    final raw = _requirePrefs.getString(StorageKeys.tasksJson);
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => TodoModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // --- Generic helpers for class demos ---

  Future<void> setString(String key, String value) async {
    await init();
    await _requirePrefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    await init();
    return _requirePrefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await init();
    await _requirePrefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    await init();
    return _requirePrefs.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await init();
    await _requirePrefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    await init();
    return _requirePrefs.getInt(key);
  }

  Future<void> remove(String key) async {
    await init();
    await _requirePrefs.remove(key);
  }

  Future<void> clearAll() async {
    await init();
    await _requirePrefs.clear();
  }
}

import 'package:flutter/foundation.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/features/tasks/notifiers/tasks_notifier.dart';
import 'package:todo_class/models/category_model.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';

/// Holds the category list and syncs it to SharedPreferences.
/// Shared singleton so every screen reads/writes the same list.
class CategoriesNotifier extends ChangeNotifier {
  CategoriesNotifier._();

  static final CategoriesNotifier instance = CategoriesNotifier._();

  static const int maxNameLength = 20;

  static const List<CategoryModel> _defaults = [
    CategoryModel(
      id: 'default_work',
      name: 'Work',
      colorIndex: 0,
      isDefault: true,
    ),
    CategoryModel(
      id: 'default_personal',
      name: 'Personal',
      colorIndex: 1,
      isDefault: true,
    ),
    CategoryModel(
      id: 'default_home',
      name: 'Home',
      colorIndex: 2,
      isDefault: true,
    ),
    CategoryModel(
      id: 'default_study',
      name: 'Study',
      colorIndex: 4,
      isDefault: true,
    ),
    CategoryModel(
      id: 'default_health',
      name: 'Health',
      colorIndex: 3,
      isDefault: true,
    ),
  ];

  final List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => List.unmodifiable(_categories);

  CategoryModel? findById(String? id) {
    if (id == null) return null;
    for (final category in _categories) {
      if (category.id == id) return category;
    }
    return null;
  }

  /// Call once at app start (after LocalStorageService.init).
  /// Seeds the default categories on first launch.
  Future<void> load() async {
    final saved = await LocalStorageService.instance.loadCategories();
    _categories
      ..clear()
      ..addAll(saved ?? _defaults);
    if (saved == null) await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    await LocalStorageService.instance.saveCategories(_categories);
  }

  /// Returns an error message, or null when [name] is a valid new category.
  String? validateName(String? name) {
    final trimmed = name?.trim() ?? '';
    if (trimmed.isEmpty) return 'Name is required';
    if (trimmed.length > maxNameLength) {
      return 'Keep it under $maxNameLength characters';
    }
    final exists = _categories.any(
      (category) => category.name.toLowerCase() == trimmed.toLowerCase(),
    );
    if (exists) return 'Category already exists';
    return null;
  }

  /// Adds a category and returns it (null if the name is invalid).
  Future<CategoryModel?> addCategory(String name) async {
    if (validateName(name) != null) return null;

    final category = CategoryModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      colorIndex: _categories.length % AppColors.categoryPalette.length,
    );
    _categories.add(category);
    notifyListeners();
    await _persist();
    return category;
  }

  /// Deletes a user-created category; its tasks become uncategorized.
  Future<void> deleteCategory(String id) async {
    final category = findById(id);
    if (category == null || category.isDefault) return;

    _categories.removeWhere((item) => item.id == id);
    notifyListeners();
    await _persist();
    await TasksNotifier.instance.uncategorizeTasks(id);
  }
}

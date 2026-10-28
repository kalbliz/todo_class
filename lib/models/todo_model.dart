/// Simple Todo data model.
/// Logic/UI should depend on this model, not on raw maps.
class TodoModel {
  const TodoModel({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.dueDate,
    this.createdAt,
    this.categoryId,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;
  final DateTime? createdAt;

  /// Null means the task is uncategorized.
  final String? categoryId;

  /// Pass [clearCategory] = true to make the task uncategorized,
  /// because `categoryId: null` alone means "keep the current value".
  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? dueDate,
    DateTime? createdAt,
    String? categoryId,
    bool clearCategory = false,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      categoryId: clearCategory ? null : (categoryId ?? this.categoryId),
    );
  }

  /// Convert to a map so we can jsonEncode it for SharedPreferences.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'categoryId': categoryId,
    };
  }

  /// Rebuild a TodoModel from the map we stored as JSON.
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      categoryId: json['categoryId'] as String?,
    );
  }
}

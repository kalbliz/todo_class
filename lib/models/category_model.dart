/// A task category (e.g. Work, Personal).
/// [colorIndex] points into AppColors.categoryPalette.
class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    this.colorIndex = 0,
    this.isDefault = false,
  });

  final String id;
  final String name;
  final int colorIndex;

  /// Default categories are seeded on first launch and cannot be deleted.
  final bool isDefault;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'colorIndex': colorIndex,
      'isDefault': isDefault,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      colorIndex: json['colorIndex'] as int? ?? 0,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }
}

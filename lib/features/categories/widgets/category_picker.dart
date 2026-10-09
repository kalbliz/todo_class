import 'package:flutter/material.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/categories/notifiers/categories_notifier.dart';
import 'package:todo_class/features/categories/widgets/add_category_dialog.dart';
import 'package:todo_class/models/category_model.dart';
import 'package:todo_class/utils/chips/app_chip.dart';
import 'package:todo_class/utils/dialogs/app_dialog.dart';

/// Lets the user pick one (optional) category or create a new one.
/// Tap a selected chip again to clear it. Long-press a custom
/// category to delete it.
class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  final String? selectedId;
  final ValueChanged<String?> onChanged;

  Future<void> _addCategory(BuildContext context) async {
    final created = await AddCategoryDialog.show(context);
    if (created != null) onChanged(created.id);
  }

  Future<void> _deleteCategory(
    BuildContext context,
    CategoryModel category,
  ) async {
    final confirmed = await AppDialogs.confirm(
      context: context,
      title: 'Delete "${category.name}"?',
      message: 'Tasks in this category will become uncategorized.',
      confirmLabel: 'Delete',
      isDestructive: true,
    );
    if (confirmed != true) return;

    if (selectedId == category.id) onChanged(null);
    await CategoriesNotifier.instance.deleteCategory(category.id);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = CategoriesNotifier.instance;

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category', style: AppTextStyles.label),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final category in notifier.categories)
                  AppChip(
                    label: category.name,
                    color: AppColors.categoryColor(category.colorIndex),
                    isSelected: category.id == selectedId,
                    onTap: () => onChanged(
                      category.id == selectedId ? null : category.id,
                    ),
                    onLongPress: category.isDefault
                        ? null
                        : () => _deleteCategory(context, category),
                  ),
                AppChip(
                  label: 'New',
                  icon: Icons.add,
                  color: AppColors.textSecondary,
                  onTap: () => _addCategory(context),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

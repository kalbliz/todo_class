import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/features/categories/notifiers/categories_notifier.dart';
import 'package:todo_class/models/category_model.dart';
import 'package:todo_class/models/todo_model.dart';

/// Shared task card used on Home, Calendar, and Tasks lists.
class HomeTaskCard extends StatelessWidget {
  const HomeTaskCard({
    super.key,
    required this.task,
    required this.onToggleComplete,
    this.onTap,
  });

  final TodoModel task;
  final ValueChanged<bool?> onToggleComplete;
  final VoidCallback? onTap;

  static const Color cardColor = Color(0xFFF1F2F4);
  static const Color mutedColor = Color(0xFF777777);

  String get _timeLabel {
    final due = task.dueDate;
    if (due == null) return 'No time';

    final now = DateTime.now();
    final isToday =
        due.year == now.year && due.month == now.month && due.day == now.day;
    final time =
        '${due.hour.toString().padLeft(2, '0')}:${due.minute.toString().padLeft(2, '0')}';

    if (isToday) return 'Today At $time';
    return '${due.day}/${due.month}/${due.year} At $time';
  }

  CategoryModel? get _category =>
      task.category ?? CategoriesNotifier.instance.findById(task.categoryId);

  Color get _categoryColor {
    final category = _category;
    if (category == null) return const Color(0xFFE5E7EB);
    if (category.color != Colors.grey) return category.color;
    return AppColors.categoryColor(category.colorIndex);
  }

  IconData get _categoryIcon {
    switch (_category?.name.toLowerCase()) {
      case 'work':
        return Iconsax.briefcase;
      case 'home':
        return Iconsax.home;
      case 'study':
      case 'university':
        return Iconsax.book;
      case 'health':
        return Iconsax.health;
      case 'personal':
        return Iconsax.user;
      default:
        return Iconsax.tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = _category;
    final categoryName = category?.name ?? 'Uncategorized';
    final hasDescription = task.description.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 35,
                child: Checkbox(
                  value: task.isCompleted,
                  onChanged: onToggleComplete,
                  shape: const CircleBorder(),
                  side: const BorderSide(
                    color: Color(0xFF888888),
                    width: 1.7,
                  ),
                  activeColor: const Color(0xFF71D5E8),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        color: task.isCompleted ? mutedColor : Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    if (hasDescription) ...[
                      const SizedBox(height: 6),
                      Text(
                        task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: task.isCompleted
                              ? mutedColor.withValues(alpha: 0.8)
                              : mutedColor,
                          fontSize: 13,
                          height: 1.3,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Text(
                      _timeLabel,
                      style: const TextStyle(
                        color: mutedColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _MetaChip(
                          backgroundColor: _categoryColor,
                          bordered: false,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _categoryIcon,
                                size: 13,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                categoryName,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _MetaChip(
                          backgroundColor: Colors.transparent,
                          bordered: true,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Iconsax.flag,
                                size: 14,
                                color: mutedColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'P${task.priority}',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.child,
    required this.backgroundColor,
    required this.bordered,
  });

  final Widget child;
  final Color backgroundColor;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: bordered
            ? Border.all(color: const Color(0xFFB0B0B0))
            : null,
      ),
      child: child,
    );
  }
}

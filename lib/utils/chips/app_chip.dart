import 'package:flutter/material.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';

/// Shared selectable chip (categories, filters, tags).
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.color = AppColors.primary,
    this.isSelected = false,
    this.icon,
    this.onTap,
    this.onLongPress,
  });

  final String label;
  final Color color;
  final bool isSelected;
  final IconData? icon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? AppColors.surface : color;

    return Material(
      color: isSelected ? color : color.withValues(alpha: 0.1),
      shape: StadiumBorder(side: BorderSide(color: color)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: AppTextStyles.label.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

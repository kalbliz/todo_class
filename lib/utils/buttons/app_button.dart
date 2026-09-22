import 'package:flutter/material.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/utils/buttons/app_leading_icon.dart';

/// Shared button widgets.
/// Pass [icon] (IconData) or [assetPath] (svg/png) to show a leading graphic.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isExpanded = true,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.assetPath,
    this.iconSize = 20,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final String? assetPath;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final foreground = textColor ?? Colors.white;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: foreground,
        disabledBackgroundColor: AppColors.disabled,
        minimumSize: Size(isExpanded ? double.infinity : 0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foreground,
              ),
            )
          : _ButtonLabel(
              label: label,
              labelStyle: AppTextStyles.button.copyWith(color: foreground),
              icon: icon,
              assetPath: assetPath,
              iconColor: foreground,
              iconSize: iconSize,
            ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isExpanded = true,
    this.icon,
    this.assetPath,
    this.iconSize = 20,
    this.borderColor,
    this.textColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isExpanded;
  final IconData? icon;
  final String? assetPath;
  final double iconSize;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final foreground = textColor ?? AppColors.primary;
    final sideColor = borderColor ?? AppColors.primary;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foreground,
        minimumSize: Size(isExpanded ? double.infinity : 0, 48),
        side: BorderSide(color: sideColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _ButtonLabel(
        label: label,
        labelStyle: AppTextStyles.button.copyWith(color: foreground),
        icon: icon,
        assetPath: assetPath,
        iconColor: foreground,
        iconSize: iconSize,
      ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.assetPath,
    this.iconSize = 18,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final String? assetPath;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: _ButtonLabel(
        label: label,
        labelStyle: AppTextStyles.body.copyWith(color: AppColors.primary),
        icon: icon,
        assetPath: assetPath,
        iconColor: AppColors.primary,
        iconSize: iconSize,
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    this.icon,
    this.assetPath,
    required this.onPressed,
    this.color,
    this.size = 24,
  }) : assert(
          icon != null || assetPath != null,
          'Provide either icon or assetPath',
        );

  final IconData? icon;
  final String? assetPath;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: AppLeadingIcon(
        icon: icon,
        assetPath: assetPath,
        color: color ?? AppColors.textPrimary,
        size: size,
      ),
    );
  }
}

class _ButtonLabel extends StatelessWidget {
  const _ButtonLabel({
    required this.label,
    required this.labelStyle,
    this.icon,
    this.assetPath,
    this.iconColor,
    this.iconSize = 20,
  });

  final String label;
  final TextStyle labelStyle;
  final IconData? icon;
  final String? assetPath;
  final Color? iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final hasLeading = icon != null || assetPath != null;

    if (!hasLeading) {
      return Text(label, style: labelStyle);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppLeadingIcon(
          icon: icon,
          assetPath: assetPath,
          color: iconColor,
          size: iconSize,
        ),
        const SizedBox(width: 8),
        Flexible(child: Text(label, style: labelStyle)),
      ],
    );
  }
}

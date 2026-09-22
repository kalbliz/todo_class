import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders an IconData, SVG, or raster image for buttons and UI chrome.
class AppLeadingIcon extends StatelessWidget {
  const AppLeadingIcon({
    super.key,
    this.icon,
    this.assetPath,
    this.color,
    this.size = 20,
  }) : assert(
          icon != null || assetPath != null,
          'Provide either icon or assetPath',
        );

  final IconData? icon;
  final String? assetPath;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Icon(icon, size: size, color: color);
    }

    final path = assetPath!;
    if (path.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: size,
        height: size,
        colorFilter: color == null
            ? null
            : ColorFilter.mode(color!, BlendMode.srcIn),
      );
    }

    return Image.asset(
      path,
      width: size,
      height: size,
      color: color,
      fit: BoxFit.contain,
    );
  }
}

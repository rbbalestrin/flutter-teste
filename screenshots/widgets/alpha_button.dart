import 'package:flutter/material.dart';
import '../constants/theme.dart';

class AlphaButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color color;
  final bool isOutlined;
  final bool isFullWidth;
  final double height;
  final double? width;
  final double borderRadius;

  const AlphaButton({
    Key? key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.color = AlphaColors.primary,
    this.isOutlined = false,
    this.isFullWidth = true,
    this.height = 50,
    this.width,
    this.borderRadius = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: isOutlined
            ? null
            : [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: isOutlined ? Colors.transparent : color,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            decoration: isOutlined
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  )
                : null,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: icon != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isOutlined ? color : Colors.white,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    label,
                    textAlign: icon != null ? TextAlign.left : TextAlign.center,
                    style: TextStyle(
                      color: isOutlined ? color : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
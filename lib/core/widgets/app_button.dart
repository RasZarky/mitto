import 'package:flutter/material.dart';
import 'package:mitto/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.backgroundColor = AppColors.secondary200,
    this.textColor = AppColors.basicBlack,
    this.height = 80,
    this.borderRadius = 32,
    this.gap = 8,
    this.padding = const EdgeInsets.only(
      top: 14,
      right: 16,
      bottom: 14,
      left: 16,
    ),
    this.icon,
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final double gap;
  final EdgeInsetsGeometry padding;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: padding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: gap),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

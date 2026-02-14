import 'package:flutter/material.dart';
import 'package:mitto/core/theme/app_colors.dart';

enum AppButtonIconPosition { left, right }

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
    this.iconPosition = AppButtonIconPosition.left,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final double gap;
  final EdgeInsetsGeometry padding;
  final Widget? icon;
  final AppButtonIconPosition iconPosition;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: padding,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBackgroundColor: backgroundColor.withAlpha(153),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.basicBlack,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null && iconPosition == AppButtonIconPosition.left) ...[
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
                  if (icon != null && iconPosition == AppButtonIconPosition.right) ...[
                    SizedBox(width: gap),
                    icon!,
                  ],
                ],
              ),
      ),
    );
  }
}

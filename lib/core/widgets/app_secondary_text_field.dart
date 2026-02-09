import 'package:flutter/material.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';

class AppSecondaryTextField extends StatelessWidget {
  const AppSecondaryTextField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
  });

  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.gray600,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(top: 8, right: 8, bottom: 8, left: 16),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: AppColors.gray400,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyle.baseMedium.copyWith(
                color: AppColors.basicWhite,
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyle.baseRegular.copyWith(
                  color: AppColors.gray400,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

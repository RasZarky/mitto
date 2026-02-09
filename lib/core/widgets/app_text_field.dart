import 'package:flutter/material.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.onChanged,
  });

  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword || widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    // Height 80. Font size 16, height 1.5 = 24. 
    // Vertical padding = (80 - 24) / 2 = 28.
    const double verticalPadding = 28;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 80,
          child: TextField(
            controller: widget.controller,
            obscureText: _isObscured,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            // We set maxLines to 1 to support obscureText, 
            // and use contentPadding to ensure it stays 80px high.
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            style: AppTextStyle.baseMedium.copyWith(color: AppColors.basicWhite),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyle.baseRegular.copyWith(color: AppColors.gray400),
              fillColor: AppColors.gray800,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: verticalPadding),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.gray400,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: AppColors.secondary200, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: AppColors.accentRed, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: const BorderSide(color: AppColors.accentRed, width: 2),
              ),
              // Use an empty string for errorText to trigger the error border without the default error widget
              errorText: widget.errorText != null ? '' : null,
              errorStyle: const TextStyle(height: 0, fontSize: 0),
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              widget.errorText!,
              style: AppTextStyle.xsRegular.copyWith(color: AppColors.accentRed),
            ),
          ),
        ],
      ],
    );
  }
}

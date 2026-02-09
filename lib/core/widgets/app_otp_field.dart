import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';

class AppOtpField extends StatefulWidget {
  const AppOtpField({
    super.key,
    required this.onCompleted,
    this.hasError = false,
    this.errorText,
  });

  final Function(String) onCompleted;
  final bool hasError;
  final String? errorText;

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verify();
      }
    } else {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  void _verify() {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length == 4) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 80,
              height: 80,
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                onChanged: (value) => _onChanged(value, index),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                expands: true,
                maxLines: null,
                minLines: null,
                style: AppTextStyle.h3Semibold.copyWith(color: AppColors.basicWhite),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  fillColor: AppColors.gray800,
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: widget.hasError ? AppColors.accentRed : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide(
                      color: widget.hasError ? AppColors.accentRed : AppColors.secondary200,
                      width: 2,
                    ),
                  ),
                ),
              ),
            );
          }),
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

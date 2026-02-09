import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';

class AppPhoneField extends StatefulWidget {
  const AppPhoneField({
    super.key,
    required this.onInputChanged,
    this.initialValue,
    this.textFieldController,
    this.errorText,
  });

  final ValueChanged<PhoneNumber> onInputChanged;
  final PhoneNumber? initialValue;
  final TextEditingController? textFieldController;
  final String? errorText;

  @override
  State<AppPhoneField> createState() => _AppPhoneFieldState();
}

class _AppPhoneFieldState extends State<AppPhoneField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final Color borderColor = hasError
        ? AppColors.accentRed
        : _isFocused
            ? AppColors.secondary200
            : Colors.transparent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Selector Container
            Container(
              width: 115,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.gray800,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
              ),
              child: InternationalPhoneNumberInput(
                onInputChanged: widget.onInputChanged,
                initialValue: widget.initialValue ?? PhoneNumber(isoCode: 'CA'),
                textFieldController: widget.textFieldController,
                focusNode: _focusNode,
                cursorColor: AppColors.basicWhite,
                formatInput: false,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  setSelectorButtonAsPrefixIcon: false,
                  leadingPadding: 10,
                  trailingSpace: false
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: AppTextStyle.baseMedium.copyWith(color: AppColors.basicWhite),
                // We make the text field part invisible in this first container
                textStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
                inputDecoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  counterText: '',
                ),
                // This instance only serves as the selector
                searchBoxDecoration: InputDecoration(
                  hintText: 'Search country',
                  hintStyle: AppTextStyle.baseRegular.copyWith(color: AppColors.gray400),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Phone Number Input Container
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.gray800,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: borderColor,
                    width: 2,
                  ),
                ),
                // We use another instance of InternationalPhoneNumberInput but hide the selector
                // Or we can just use a normal TextField if we handle the phone logic correctly.
                // However, the library is better for formatting.
                // Let's try to use the same FocusNode and logic.
                child: InternationalPhoneNumberInput(
                  onInputChanged: widget.onInputChanged,
                  initialValue: widget.initialValue ?? PhoneNumber(isoCode: 'CA'),
                  textFieldController: widget.textFieldController,
                  focusNode: _focusNode,
                  cursorColor: AppColors.basicWhite,
                  formatInput: false,
                  // Hide selector in this one
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    showFlags: false,
                    setSelectorButtonAsPrefixIcon: false,
                  ),
                  selectorTextStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
                  textStyle: AppTextStyle.baseMedium.copyWith(color: AppColors.basicWhite),
                  inputDecoration: InputDecoration(
                    hintText: 'Phone number',
                    hintStyle: AppTextStyle.baseRegular.copyWith(color: AppColors.gray400),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (hasError) ...[
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

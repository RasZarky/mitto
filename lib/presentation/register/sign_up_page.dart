import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mitto/core/router/app_router.dart';
import 'package:mitto/core/widgets/app_button.dart';
import 'package:mitto/core/widgets/app_text_field.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../core/widgets/app_app_bar.dart';
import '../../core/widgets/app_phone_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  String? _emailError;
  String? _phoneError;
  
  PhoneNumber number = PhoneNumber(isoCode: 'CA');

  void _validateAndNavigate() {
    setState(() {
      _emailError = null;
      _phoneError = null;
    });

    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    bool isValid = true;

    if (email.isEmpty) {
      setState(() => _emailError = 'Email is required');
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => _emailError = 'Enter a valid email address');
      isValid = false;
    }

    if (phone.isEmpty) {
      setState(() => _phoneError = 'Phone number is required');
      isValid = false;
    }

    if (isValid) {
      context.push(AppRouter.verification);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: const AppAppBar(
        title: 'Sign up',
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create your \nMitto account',
                      style: AppTextStyle.h1Semibold),
                  const SizedBox(height: 8),
                  Text(
                    'We just need a few details.',
                    style: AppTextStyle.lgRegular.copyWith(fontSize: 14),
                  ),
                  const Spacer(),
                  AppTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    errorText: _emailError,
                    onChanged: (_) {
                      if (_emailError != null) {
                        setState(() => _emailError = null);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppPhoneField(
                    initialValue: number,
                    textFieldController: _phoneController,
                    errorText: _phoneError,
                    onInputChanged: (PhoneNumber number) {
                      setState(() {
                        this.number = number;
                      });
                      if (_phoneError != null) {
                        setState(() => _phoneError = null);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    text: 'Continue',
                    onPressed: _validateAndNavigate,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: 'By clicking “sign up”, you agree to Lyte Digital’s ',
                        style: AppTextStyle.xsRegular,
                        children: [
                          TextSpan(
                            text: 'Terms of service',
                            style: AppTextStyle.xsRegular.copyWith(
                                color: AppColors.secondary200),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyle.xsRegular.copyWith(
                                color: AppColors.secondary200),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

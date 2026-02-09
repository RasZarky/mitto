import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mitto/core/router/app_router.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';
import 'package:mitto/core/widgets/app_app_bar.dart';
import 'package:mitto/core/widgets/app_otp_field.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool _hasError = false;
  bool _isLoading = false;

  void _verifyOtp(String otp) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Simple mock validation: "1234" is correct
      if (otp == '1234') {
        // Navigate to home or success page
        context.go(AppRouter.splash); 
      } else {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: const AppAppBar(
        title: 'Verify Account',
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
                  Text('Verify your \naccount', style: AppTextStyle.h1Semibold),
                  const SizedBox(height: 8),
                  Text(
                    'We’ve sent a code to \nyourname@email.com.',
                    style: AppTextStyle.lgRegular.copyWith(fontSize: 14),
                  ),
                  const Spacer(),
                  AppOtpField(
                    hasError: _hasError,
                    errorText: _hasError ? 'Code you entered is incorrect. Please try again.' : null,
                    onCompleted: _verifyOtp,
                  ),
                  const SizedBox(height: 24),
                  if (_isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.secondary200,
                        strokeWidth: 2,
                      ),
                    ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: "Didn't get email?  ",
                        style: AppTextStyle.xsRegular,
                        children: [
                          TextSpan(
                            text: 'Resend',
                            style: AppTextStyle.xsRegular
                                .copyWith(color: AppColors.secondary200),
                          ),
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

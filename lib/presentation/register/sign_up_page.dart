import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'CA';
  PhoneNumber number = PhoneNumber(isoCode: 'CA');

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
                  const AppTextField(
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  AppPhoneField(
                    initialValue: number,
                    textFieldController: controller,
                    onInputChanged: (PhoneNumber number) {
                      setState(() {
                        this.number = number;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  AppButton(text: 'Continue', onPressed: () {}),
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

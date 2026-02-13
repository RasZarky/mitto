import 'package:flutter/material.dart';
import 'package:mitto/core/widgets/app_button.dart';
import 'package:mitto/core/widgets/app_text_field.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../core/widgets/app_app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  Future<void> _validateAndNavigate() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    bool isValid = true;

    if (email.isEmpty) {
      setState(() => _emailError = 'Email is required');
      isValid = false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() => _emailError = 'Enter a valid email address');
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = 'Password is required');
      isValid = false;
    }

    if (isValid) {
      setState(() => _isLoading = true);
      
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() => _isLoading = false);
        context.go(AppRouter.navBase);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: const AppAppBar(
        title: 'Log in',
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
                  Text('Get Started', style: AppTextStyle.h1Semibold),
                  const SizedBox(height: 8),
                  Text(
                    'Enter email and continue',
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
                  AppTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    errorText: _passwordError,
                    onChanged: (_) {
                      if (_passwordError != null) {
                        setState(() => _passwordError = null);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    text: 'Login',
                    onPressed: _validateAndNavigate,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyle.baseRegular,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

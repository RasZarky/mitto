import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mitto/core/widgets/app_button.dart';
import 'package:mitto/core/widgets/app_text_field.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../core/widgets/app_app_bar.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  String? _passwordError;
  String? _confirmPasswordError;
  bool _isBiometricsEnabled = false;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      setState(() {
        _isBiometricAvailable = canAuthenticate;
      });
    } catch (e) {
      debugPrint('Error checking biometrics: $e');
    }
  }

  void _validateAndNavigate() async {
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;
    });

    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    bool isValid = true;

    if (password.isEmpty) {
      setState(() => _passwordError = 'Password is required');
      isValid = false;
    } else if (password.length < 8) {
      setState(() => _passwordError = 'Password must be at least 8 characters');
      isValid = false;
    }

    if (confirmPassword.isEmpty) {
      setState(() => _confirmPasswordError = 'Please confirm your password');
      isValid = false;
    } else if (password != confirmPassword) {
      setState(() => _confirmPasswordError = 'Passwords do not match');
      isValid = false;
    }

    if (isValid) {
      if (_isBiometricsEnabled) {
        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to enable biometrics',
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
            ),
          );
          if (!didAuthenticate) {
            // If authentication fails, we might want to inform the user or just not enable it.
            // For now, let's just proceed or show a snackbar.
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Biometric authentication failed')),
              );
            }
            return;
          }
        } catch (e) {
          debugPrint('Error authenticating: $e');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
          }
          return;
        }
      }
      
      // Navigate to splash or home after account creation
      if (mounted) {
        context.go(AppRouter.splash);
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      appBar: const AppAppBar(
        title: 'Create Password',
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
                  Text('Create a secure password',
                      style: AppTextStyle.h1Semibold),
                  const SizedBox(height: 8),
                  Text(
                    'Use at least 8 characters to protect your account.',
                    style: AppTextStyle.lgRegular.copyWith(fontSize: 14),
                  ),
                  const Spacer(),
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
                  AppTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    isPassword: true,
                    errorText: _confirmPasswordError,
                    onChanged: (_) {
                      if (_confirmPasswordError != null) {
                        setState(() => _confirmPasswordError = null);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  if (_isBiometricAvailable)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enable biometrics', 
                          style: AppTextStyle.lgRegular.copyWith(color: AppColors.secondary200)),
                        Switch(
                          activeThumbColor: AppColors.gray50,
                          inactiveThumbColor: AppColors.gray50,
                          activeTrackColor: AppColors.secondary200,
                          value: _isBiometricsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _isBiometricsEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  AppButton(
                    text: 'Continue',
                    onPressed: _validateAndNavigate,
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

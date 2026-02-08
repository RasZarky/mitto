import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mitto/core/router/app_router.dart';
import 'package:mitto/core/theme/app_colors.dart';

import '../../gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(AppRouter.getStarted);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: Center(
        child: Assets.images.logo.image(
          height: 85,
          width: 235,
        ),
      ),
    );
  }
}

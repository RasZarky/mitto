import 'package:flutter/material.dart';
import 'package:mitto/core/theme/app_colors.dart';

import '../../gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: Center(
        child: Assets.images.logo.image(
          height: 85,
          width: 235,
        ),
      )
    );
  }
}

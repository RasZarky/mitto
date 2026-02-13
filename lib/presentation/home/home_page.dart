import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';

import '../../core/widgets/app_app_bar.dart';
import '../../core/widgets/app_button.dart';
import '../../gen/assets.gen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary700,
      appBar: AppAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=john'),
              ),
              const SizedBox(width: 8),
              Text(
                'Hi, John',
                style: AppTextStyle.lgMedium.copyWith(color: AppColors.gray900),
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(Assets.svgs.notification),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your balance',
                        style: AppTextStyle.lgMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isBalanceVisible = !_isBalanceVisible;
                          });
                        },
                        child: Icon(
                          _isBalanceVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.basicWhite,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isBalanceVisible ? '\$ 4,925.00' : '\$ ********',
                    style: AppTextStyle.lgMedium.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w600,
                        color: AppColors.basicWhite),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Send',
                          backgroundColor: AppColors.gray50,
                          onPressed: () {},
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: AppButton(
                          text: 'Pay',
                          backgroundColor: AppColors.gray700,
                          textColor: AppColors.basicWhite,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                      text: 'Add money',
                      onPressed: (){}),
                  const SizedBox(height: 24),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

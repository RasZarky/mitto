import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/core/theme/app_text_style.dart';
import 'package:mitto/core/widgets/app_transaction_tile.dart';

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
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQshxDayjc43aO8e5d2Ka42EZGb1N3BT46nrIqxClbOgQ&s'),
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
                        style: AppTextStyle.lgMedium.copyWith(color: AppColors.basicWhite),
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
                          icon: SvgPicture.asset(Assets.svgs.send),
                          backgroundColor: AppColors.gray50,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppButton(
                          text: 'Pay',
                          icon: SvgPicture.asset(Assets.svgs.card),
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
                      iconPosition: AppButtonIconPosition.right,
                      icon: Expanded(
                          child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: SvgPicture.asset(Assets.svgs.plus))),
                      onPressed: () {}),
                  const SizedBox(height: 16),
                  Text(
                    'Send again to',
                    style: AppTextStyle.h5Medium.copyWith(color: AppColors.basicWhite),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: AppColors.gray700,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.basicWhite,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ...[
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
                          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
                          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150'
                        ]
                            .map((url) => Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // TODO: Implement send to this recipient
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.gray700,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: CachedNetworkImage(
                                          imageUrl: url,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: AppColors.basicWhite,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.person, color: AppColors.basicWhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transactions',
                        style: AppTextStyle.h5Medium.copyWith(color: AppColors.basicWhite),
                      ),
                      Text(
                        'See all',
                        style: AppTextStyle.smRegular.copyWith(color: AppColors.secondary200),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const AppTransactionTile(
                    title: 'Money sent to Eddie',
                    subtitle: '8:24 PM',
                    amount: '-\$ 120.00',
                    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
                  ),
                  const SizedBox(height: 16),
                  const AppTransactionTile(
                    title: 'Money sent to Akua',
                    subtitle: '8:24 PM',
                    amount: '-\$ 120.00',
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLDflof01UiGhww5AjOb6_6yV9Nd1VtR2IYw&s',
                  ),
                  const SizedBox(height: 16),
                  const AppTransactionTile(
                    title: 'Money sent to Kofi',
                    subtitle: '8:24 PM',
                    amount: '-\$ 120.00',
                    imageUrl: 'https://img.freepik.com/free-photo/portrait-person-wearing-graphic-eye-makeup_23-2151120756.jpg?semt=ais_user_personalization&w=740&q=80',
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mitto/core/router/app_router.dart';
import 'package:mitto/core/theme/app_colors.dart';

import '../../core/theme/app_text_style.dart';
import '../../core/widgets/app_button.dart';
import '../../gen/assets.gen.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Send money home. Instantly',
      'image': Assets.images.phone2,
    },
    {
      'title': 'Clear rates. No hidden charges.',
      'image': Assets.images.phone1,
    },
    {
      'title': 'Faster. Cheaper. Trusted',
      'image': Assets.images.phone2,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoCycle();
  }

  void _startAutoCycle() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _items.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20),
          child: Column(
            children: [
              // Indicators
              Row(
                children: List.generate(
                  _items.length,
                  (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: _currentPage >= index
                            ? AppColors.secondary200
                            : AppColors.gray700,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Column(
                      children: [
                        Text(
                          item['title'] as String,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.h2Semibold,
                        ),
                        const SizedBox(height: 48),
                        Expanded(
                          child: (item['image'] as AssetGenImage).image(
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      backgroundColor: AppColors.gray50,
                      text: 'Login',
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: 'Get Started',
                      onPressed: () => context.push(AppRouter.signUp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mitto/core/theme/app_colors.dart';
import 'package:mitto/gen/assets.gen.dart';
import 'package:mitto/presentation/explore/explore_page.dart';
import 'package:mitto/presentation/home/home_page.dart';
import 'package:mitto/presentation/transactions/transactions_page.dart';

class NavBase extends StatefulWidget {
  const NavBase({super.key});

  @override
  State<NavBase> createState() => _NavBaseState();
}

class _NavBaseState extends State<NavBase> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TransactionsPage(),
    const ExplorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray900,
      body: Stack(
        children: [
          _pages[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18.9, sigmaY: 18.9),
                  child: CustomPaint(
                    painter: _GradientBorderPainter(
                      radius: 1000,
                      strokeWidth: 1,
                      gradient: const LinearGradient(
                        begin: Alignment(-0.9, -0.1), // Approx 93.37deg
                        end: Alignment(0.9, 0.1),
                        stops: [0.1153, 0.5427, 0.9277],
                        colors: [
                          Color(0x0FFFFFFF), // 0.0582292 opacity approx
                          Color(0x21FFFFFF), // 0.13 opacity
                          Color(0x00FFFFFF), // 0 opacity
                        ],
                      ),
                    ),
                    child: Container(
                      width: 232,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(26),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _NavBarItem(
                            svgPath: Assets.svgs.home,
                            isSelected: _currentIndex == 0,
                            onTap: () => setState(() => _currentIndex = 0),
                          ),
                          _NavBarItem(
                            svgPath: Assets.svgs.list,
                            isSelected: _currentIndex == 1,
                            onTap: () => setState(() => _currentIndex = 1),
                          ),
                          _NavBarItem(
                            svgPath: Assets.svgs.grid,
                            isSelected: _currentIndex == 2,
                            onTap: () => setState(() => _currentIndex = 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String svgPath;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.svgPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        svgPath,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.secondary200 : AppColors.basicWhite,
          BlendMode.srcIn,
        ),
        width: 24,
        height: 24,
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientBorderPainter({
    required this.radius,
    required this.strokeWidth,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

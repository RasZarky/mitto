import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool centerTitle;
  final Widget? leading;
  final List<Widget>? actions;

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.centerTitle = true,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Container(
        width: double.maxFinite,
        height: preferredSize.height,
        decoration: const BoxDecoration(
          color: AppColors.basicWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 56.0),
                      child: centerTitle
                          ? _buildTitle()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: _buildTitle(),
                            ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: leading ?? const BackButton(color: AppColors.gray900),
                ),
                if (actions != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    if (titleWidget != null) return titleWidget!;
    return Text(
      title ?? '',
      style: AppTextStyle.baseMedium.copyWith(color: AppColors.gray900),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(114.30979919433594);
}

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

class BottomBarComponent extends StatelessWidget {
  final int selectedPage;
  const BottomBarComponent({
    Key? key,
    required this.selectedPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: selectedPage);
    return AnimatedNotchBottomBar(
      pageController: pageController,
      onTap: (index) {
        if (index == 2) {
          GoRouter.of(context).push('/maps');
        } else {
          GoRouter.of(context).push('/home');
        }
      },
      bottomBarItems: const [
        BottomBarItem(
          inActiveItem: Icon(
            Icons.menu,
            color: AppColors.background,
          ),
          activeItem: Icon(
            Icons.menu,
            color: AppColors.primary,
          ),
          itemLabel: 'menu',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.home_filled,
            color: AppColors.background,
          ),
          activeItem: Icon(
            Icons.home_filled,
            color: AppColors.primary,
          ),
          itemLabel: 'home',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.map_sharp,
            color: AppColors.background,
          ),
          activeItem: Icon(
            Icons.map_sharp,
            color: AppColors.primary,
          ),
          itemLabel: 'mapas',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeNavBarItem extends StatelessWidget {
  const HomeNavBarItem({
    super.key,
    required this.icon,
    required this.index,
    required this.navigationShell,
  });

  final String icon;
  final int index;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final selected = navigationShell.currentIndex == index;
    return GestureDetector(
      onTap: () {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      child: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

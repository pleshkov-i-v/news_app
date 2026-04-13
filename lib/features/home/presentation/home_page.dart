import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/features/home/presentation/widgets/home_nav_bar_item.dart';
import 'package:news_app/features/shared/shadow_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.navigationShell.currentIndex !=
        widget.navigationShell.currentIndex) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: ShadowContainer(
          height: 84,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeNavBarItem(
                icon: Assets.icons.navBarNewsIcon,
                index: 0,
                navigationShell: widget.navigationShell,
              ),
              HomeNavBarItem(
                icon: Assets.icons.navBarFavsIcon,
                index: 1,
                navigationShell: widget.navigationShell,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

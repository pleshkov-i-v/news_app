import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/features/favorites/presentation/favorites_page.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';
import 'package:news_app/features/home/presentation/widgets/home_nav_bar_item.dart';
import 'package:news_app/features/news/presentation/news_page.dart';
import 'package:news_app/features/shared/shadow_container.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.bottomNavIndex,
            children: const [NewsPage(), FavoritesPage()],
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: ShadowContainer(
          height: 84,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeNavBarItem(icon: Assets.icons.navBarNewsIcon, index: 0),
              HomeNavBarItem(icon: Assets.icons.navBarFavsIcon, index: 1),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

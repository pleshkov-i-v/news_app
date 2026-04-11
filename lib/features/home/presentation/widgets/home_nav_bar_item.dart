import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';

class HomeNavBarItem extends StatelessWidget {
  const HomeNavBarItem({super.key, required this.icon, required this.index});
  final String icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<HomeCubit>().setBottomNavIndex(index);
          },
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              state.bottomNavIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}

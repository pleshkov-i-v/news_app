import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/presentation/home_page.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      theme: AppTheme.light,
      home: BlocProvider<HomeCubit>(
        create: (_) => getIt<HomeCubit>(),
        child: const HomePage(),
      ),
    );
  }
}

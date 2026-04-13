import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/core/theme/app_theme.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
    Future.wait([
      Future<void>.delayed(const Duration(seconds: 1)),
      configureDependencies(),
    ]).then((_) {
      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      // replace with splash screen
      return const Center(child: CircularProgressIndicator());
    }
    return MaterialApp.router(
      title: 'News',
      theme: AppTheme.light,
      routerConfig: getIt<GoRouter>(),
    );
  }
}

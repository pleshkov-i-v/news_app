import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:news_app/features/favorites/presentation/favorites_page_content.dart';
import 'package:news_app/features/favorites/presentation/favorites_routes.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/cubit/home_state.dart';
import 'package:news_app/features/news/presentation/news_article_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final FavoritesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<FavoritesCubit>();
    _cubit.load();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            current.bottomNavIndex == 1 && previous.bottomNavIndex != 1,
        listener: (context, _) {
          context.read<FavoritesCubit>().load();
        },
        child: Navigator(
          initialRoute: FavoritesRoutes.list,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case FavoritesRoutes.list:
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => const FavoritesPageContent(),
                );
              case FavoritesRoutes.articleDetail:
                final article = settings.arguments as NewsArticle;
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (_) => NewsArticleDetailPage(article: article),
                );
              default:
                return null;
            }
          },
        ),
      ),
    );
  }
}

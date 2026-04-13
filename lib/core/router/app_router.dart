import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/features/article_details/presentation/article_details_page.dart';
import 'package:news_app/features/favorites/presentation/favorites_page.dart';
import 'package:news_app/features/home/presentation/home_page.dart';
import 'package:news_app/features/news/presentation/news_page.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

class HomeRoutes {
  static const String news = '/news';
  static const String favorites = '/favorites';
}

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: HomeRoutes.news,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomePage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: HomeRoutes.news,
                builder: (context, state) => const NewsPage(),
                routes: [
                  GoRoute(
                    path: 'article',
                    builder: (context, state) {
                      final article = state.extra as NewsArticle?;
                      if (article == null) {
                        return const _MissingArticleScreen();
                      }
                      return ArticleDetailsPage(article: article);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: HomeRoutes.favorites,
                builder: (context, state) => const FavoritesPage(),
                routes: [
                  GoRoute(
                    path: 'article',
                    builder: (context, state) {
                      final article = state.extra as NewsArticle?;
                      if (article == null) {
                        return const _MissingArticleScreen();
                      }
                      return ArticleDetailsPage(article: article);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _MissingArticleScreen extends StatelessWidget {
  const _MissingArticleScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(child: Text('Article not found.')),
    );
  }
}

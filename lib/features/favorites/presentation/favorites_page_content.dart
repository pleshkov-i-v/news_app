import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:news_app/features/favorites/cubit/favorites_state.dart';
import 'package:news_app/features/favorites/presentation/favorites_routes.dart';
import 'package:news_app/features/news/presentation/widgets/news_article_card.dart';

class FavoritesPageContent extends StatelessWidget {
  const FavoritesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: theme.colorScheme.surface,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Favorites',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              return switch (state) {
                FavoritesInitial() || FavoritesLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                FavoritesLoaded(:final articles) =>
                  articles.isEmpty
                      ? _EmptyFavorites(theme: theme)
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 140),
                          itemCount: articles.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return NewsArticleCard(
                              article: article,
                              onArticleTap: (a) async {
                                await Navigator.of(context).pushNamed(
                                  FavoritesRoutes.articleDetail,
                                  arguments: a,
                                );
                                if (context.mounted) {
                                  context.read<FavoritesCubit>().load();
                                }
                              },
                            );
                          },
                        ),
                FavoritesError() => Center(
                  child: Text(
                    'Could not load favorites.',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              };
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_outline_rounded,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Save articles from the detail screen and they will show up here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

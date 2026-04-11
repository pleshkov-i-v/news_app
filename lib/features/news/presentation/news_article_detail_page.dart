import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/core/gen/assets.gen.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';

class NewsArticleDetailPage extends StatefulWidget {
  const NewsArticleDetailPage({super.key, required this.article});

  final NewsArticle article;

  @override
  State<NewsArticleDetailPage> createState() => _NewsArticleDetailPageState();
}

class _NewsArticleDetailPageState extends State<NewsArticleDetailPage> {
  final IFavoriteNewsRepository _favorites = getIt<IFavoriteNewsRepository>();
  bool? _isFavorite;

  NewsArticle get article => widget.article;

  @override
  void initState() {
    super.initState();
    _loadFavoriteState();
  }

  Future<void> _loadFavoriteState() async {
    final value = await _favorites.isFavorite(article.url);
    if (mounted) {
      setState(() => _isFavorite = value);
    }
  }

  Future<void> _onFavoritePressed() async {
    await _favorites.toggleFavorite(article);
    final value = await _favorites.isFavorite(article.url);
    if (mounted) {
      setState(() => _isFavorite = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSaved = _isFavorite == true;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            tooltip: isSaved ? 'Remove from favorites' : 'Save to favorites',
            onPressed: _onFavoritePressed,
            icon: SvgPicture.asset(
              isSaved ? Assets.icons.favActiveIcon : Assets.icons.favIcon,
              width: 40,
              height: 40,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                article.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              if (article.description != null &&
                  article.description!.isNotEmpty) ...[
                Text(
                  article.description!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      article.source,
                      textAlign: TextAlign.end,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      article.publishedAt,
                      textAlign: TextAlign.end,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child:
                      article.imageUrl != null && article.imageUrl!.isNotEmpty
                      ? Image.network(
                          article.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              _ImagePlaceholder(theme: theme),
                        )
                      : _ImagePlaceholder(theme: theme),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                article.content,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 56,
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

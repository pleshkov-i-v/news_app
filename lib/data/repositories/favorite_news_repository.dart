import 'dart:async';

import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';
import 'package:news_app/storage/favorite_articles/favorite_article_dto.dart';
import 'package:news_app/storage/favorite_articles/shared_preferences_favorites_storage.dart';

class FavoriteNewsRepository implements IFavoriteNewsRepository {
  FavoriteNewsRepository({required SharedPreferencesFavoritesStorage storage})
    : _storage = storage;

  final SharedPreferencesFavoritesStorage _storage;
  @override
  Future<Iterable<NewsArticle>> getFavoriteArticles() async {
    final items = await _storage.getItems();
    return items.toNewsArticles();
  }

  @override
  Future<bool> isFavorite(String articleUrl) async {
    final items = await _storage.getItems();
    return items.any((e) => e.url == articleUrl);
  }

  @override
  Future<void> addFavorite(NewsArticle article) async {
    final items = await _storage.getItems();
    final item = article.toFavoriteArticleDto();
    final updatedList = [...items, item];
    await _storage.saveItems(updatedList);
    _favoriteArticlesChangedController.add(updatedList.toNewsArticles());
  }

  @override
  Future<void> removeFavorite(String articleUrl) async {
    final items = await _storage.getItems();
    final updatedList = items.where((e) => e.url != articleUrl).toList();
    await _storage.saveItems(updatedList);
    _favoriteArticlesChangedController.add(updatedList.toNewsArticles());
  }

  final StreamController<Iterable<NewsArticle>>
  _favoriteArticlesChangedController =
      StreamController<Iterable<NewsArticle>>();

  @override
  Stream<Iterable<NewsArticle>> get favoriteArticlesChangedStream =>
      _favoriteArticlesChangedController.stream.asBroadcastStream();
}

extension on FavoriteArticleDto {
  NewsArticle toNewsArticle() {
    return NewsArticle(
      source: source,
      title: title,
      description: description,
      url: url,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      content: content,
    );
  }
}

extension on NewsArticle {
  FavoriteArticleDto toFavoriteArticleDto() {
    return FavoriteArticleDto(
      source: source,
      title: title,
      description: description,
      url: url,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      content: content,
    );
  }
}

extension on Iterable<FavoriteArticleDto> {
  Iterable<NewsArticle> toNewsArticles() {
    return map((e) => e.toNewsArticle());
  }
}

import 'package:news_app/domain/models/news_article.dart';

abstract interface class IFavoriteNewsRepository {
  Future<Iterable<NewsArticle>> getFavoriteArticles();

  Future<bool> isFavorite(String articleUrl);

  Future<void> addFavorite(NewsArticle article);

  Future<void> removeFavorite(String articleUrl);

  Stream<Iterable<NewsArticle>> get favoriteArticlesChangedStream;
}

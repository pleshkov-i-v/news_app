import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/models/news_category.dart';

abstract interface class INewsArticleRepository {
  Future<List<NewsArticle>> getNewsArticles({
    NewsCategory? category,
    String? query,
    int page = 1,
  });
}

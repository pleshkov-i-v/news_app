import 'package:news_app/api/news_api_client.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/models/news_category.dart';
import 'package:news_app/domain/repositories/i_news_article_repository.dart';

class NewsArticleRepository implements INewsArticleRepository {
  NewsArticleRepository({required this.apiClient});

  final NewsApiClient apiClient;

  @override
  Future<List<NewsArticle>> getNewsArticles({
    NewsCategory? category,
    String? query,
    int page = 1,
  }) async {
    final categoryString = category?.name; // replace with a mapper
    final response = await apiClient.getTopHeadlines(
      category: categoryString,
      query: query,
      page: page,
      pageSize: 10,
      country: 'us',
    );
    return response.articles
        .map(
          // replace with a mapper
          (e) => NewsArticle(
            source: e.source?.name ?? '',
            title: e.title ?? '',
            description: e.description,
            url: e.url,
            imageUrl: e.urlToImage,
            publishedAt: _formatDate(e.publishedAt),
            content: e.content ?? '',
          ),
        )
        .toList();
  }

  static String _formatDate(DateTime? d) {
    if (d == null) return '';
    final local = d.toLocal();
    final m = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    return '$day.$m.${local.year}';
  }
}

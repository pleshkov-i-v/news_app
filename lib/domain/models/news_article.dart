import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_article.freezed.dart';

@freezed
abstract class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required String source,
    required String title,
    required String? description,
    required String url,
    required String? imageUrl,
    required String publishedAt,
    required String content,
  }) = _NewsArticle;
}

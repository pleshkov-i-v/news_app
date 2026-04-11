import 'package:json_annotation/json_annotation.dart';

part 'news_api_models.g.dart';

@JsonSerializable()
class TopHeadlinesResponse {
  TopHeadlinesResponse({
    required this.status,
    this.totalResults,
    this.articles = const [],
    this.code,
    this.message,
  });

  final String status;
  final int? totalResults;
  final List<NewsArticleDto> articles;
  final String? code;
  final String? message;

  factory TopHeadlinesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopHeadlinesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopHeadlinesResponseToJson(this);
}

@JsonSerializable()
class NewsArticleDto {
  NewsArticleDto({
    required this.source,
    this.author,
    this.title,
    this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final NewsSourceDto? source;
  final String? author;
  final String? title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  factory NewsArticleDto.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleDtoToJson(this);
}

@JsonSerializable()
class NewsSourceDto {
  NewsSourceDto({this.id, this.name});

  final String? id;
  final String? name;

  factory NewsSourceDto.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceDtoToJson(this);
}

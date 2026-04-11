// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopHeadlinesResponse _$TopHeadlinesResponseFromJson(
  Map<String, dynamic> json,
) => TopHeadlinesResponse(
  status: json['status'] as String,
  totalResults: (json['totalResults'] as num?)?.toInt(),
  articles:
      (json['articles'] as List<dynamic>?)
          ?.map((e) => NewsArticleDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  code: json['code'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$TopHeadlinesResponseToJson(
  TopHeadlinesResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'totalResults': instance.totalResults,
  'articles': instance.articles,
  'code': instance.code,
  'message': instance.message,
};

NewsArticleDto _$NewsArticleDtoFromJson(Map<String, dynamic> json) =>
    NewsArticleDto(
      source: json['source'] == null
          ? null
          : NewsSourceDto.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$NewsArticleDtoToJson(NewsArticleDto instance) =>
    <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'content': instance.content,
    };

NewsSourceDto _$NewsSourceDtoFromJson(Map<String, dynamic> json) =>
    NewsSourceDto(id: json['id'] as String?, name: json['name'] as String?);

Map<String, dynamic> _$NewsSourceDtoToJson(NewsSourceDto instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

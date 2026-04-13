// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteArticleDto _$FavoriteArticleDtoFromJson(Map<String, dynamic> json) =>
    FavoriteArticleDto(
      title: json['title'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      imageUrl: json['imageUrl'] as String?,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$FavoriteArticleDtoToJson(FavoriteArticleDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'imageUrl': instance.imageUrl,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
      'source': instance.source,
    };

FavoriteArticlesDto _$FavoriteArticlesDtoFromJson(Map<String, dynamic> json) =>
    FavoriteArticlesDto(
      items: (json['items'] as List<dynamic>)
          .map((e) => FavoriteArticleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavoriteArticlesDtoToJson(
  FavoriteArticlesDto instance,
) => <String, dynamic>{'items': instance.items};

import 'package:json_annotation/json_annotation.dart';

part 'favorite_article_dto.g.dart';

@JsonSerializable()
class FavoriteArticleDto {
  final String title;
  final String? description;
  final String url;
  final String? imageUrl;
  final String publishedAt;
  final String content;
  final String source;

  FavoriteArticleDto({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
    required this.source,
  });
  factory FavoriteArticleDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteArticleDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteArticleDtoToJson(this);
}

@JsonSerializable()
class FavoriteArticlesDto {
  final List<FavoriteArticleDto> items;

  FavoriteArticlesDto({required this.items});
  factory FavoriteArticlesDto.fromJson(Map<String, dynamic> json) =>
      _$FavoriteArticlesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteArticlesDtoToJson(this);
}

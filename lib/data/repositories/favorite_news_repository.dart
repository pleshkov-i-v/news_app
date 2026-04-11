import 'dart:convert';

import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNewsRepository implements IFavoriteNewsRepository {
  FavoriteNewsRepository();

  static const _storageKey = 'favorite_news_articles_v1';

  Future<SharedPreferences> _prefs() => SharedPreferences.getInstance();

  Future<List<Map<String, dynamic>>> _readMaps() async {
    final raw = (await _prefs()).getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return [];
      }
      return decoded
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _writeMaps(List<Map<String, dynamic>> maps) async {
    await (await _prefs()).setString(_storageKey, jsonEncode(maps));
  }

  NewsArticle _articleFromMap(Map<String, dynamic> m) {
    return NewsArticle(
      source: m['source'] as String,
      title: m['title'] as String,
      description: m['description'] as String?,
      url: m['url'] as String,
      imageUrl: m['imageUrl'] as String?,
      publishedAt: m['publishedAt'] as String,
      content: m['content'] as String,
    );
  }

  Map<String, dynamic> _articleToMap(NewsArticle article) {
    return {
      'source': article.source,
      'title': article.title,
      'description': article.description,
      'url': article.url,
      'imageUrl': article.imageUrl,
      'publishedAt': article.publishedAt,
      'content': article.content,
    };
  }

  @override
  Future<List<NewsArticle>> getFavoriteArticles() async {
    final maps = await _readMaps();
    return maps.map(_articleFromMap).toList();
  }

  @override
  Future<bool> isFavorite(String articleUrl) async {
    final maps = await _readMaps();
    return maps.any((m) => m['url'] == articleUrl);
  }

  @override
  Future<void> addFavorite(NewsArticle article) async {
    final maps = await _readMaps();
    maps.removeWhere((m) => m['url'] == article.url);
    maps.add(_articleToMap(article));
    await _writeMaps(maps);
  }

  @override
  Future<void> removeFavorite(String articleUrl) async {
    final maps = await _readMaps();
    maps.removeWhere((m) => m['url'] == articleUrl);
    await _writeMaps(maps);
  }

  @override
  Future<void> toggleFavorite(NewsArticle article) async {
    if (await isFavorite(article.url)) {
      await removeFavorite(article.url);
    } else {
      await addFavorite(article);
    }
  }
}

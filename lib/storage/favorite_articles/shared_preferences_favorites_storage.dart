import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/storage/favorite_articles/favorite_article_dto.dart';

class SharedPreferencesFavoritesStorage {
  SharedPreferencesFavoritesStorage({required SharedPreferences preferences})
    : _preferences = preferences;

  final SharedPreferences _preferences;
  static const _storageKey = 'favorite_news_articles_v1';

  Future<List<FavoriteArticleDto>> getItems() async {
    final raw = _preferences.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return const [];
    }
    try {
      final decoded = jsonDecode(raw);
      final favoriteArticlesDto = FavoriteArticlesDto.fromJson(decoded);

      return favoriteArticlesDto.items;
    } catch (_) {
      return const [];
    }
  }

  Future<void> saveItems(List<FavoriteArticleDto> items) async {
    final favoriteArticlesDto = FavoriteArticlesDto(items: items);
    await _preferences.setString(
      _storageKey,
      jsonEncode(favoriteArticlesDto.toJson()),
    );
  }
}

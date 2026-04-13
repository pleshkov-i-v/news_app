import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/api/dio_factory.dart';
import 'package:news_app/api/news_api_client.dart';
import 'package:news_app/core/router/app_router.dart';
import 'package:news_app/data/repositories/favorite_news_repository.dart';
import 'package:news_app/data/repositories/news_article_repository.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';
import 'package:news_app/domain/repositories/i_news_article_repository.dart';
import 'package:news_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:news_app/storage/favorite_articles/shared_preferences_favorites_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<GoRouter>(createAppRouter());

  getIt.registerLazySingleton<NewsApiClient>(
    () => NewsApiClient(DioFactory().createDio()),
  );
  getIt.registerFactory<INewsArticleRepository>(
    () => NewsArticleRepository(apiClient: getIt<NewsApiClient>()),
  );
  getIt.registerLazySingleton<SharedPreferencesFavoritesStorage>(
    () => SharedPreferencesFavoritesStorage(preferences: sharedPreferences),
  );
  getIt.registerLazySingleton<IFavoriteNewsRepository>(
    () => FavoriteNewsRepository(
      storage: getIt<SharedPreferencesFavoritesStorage>(),
    ),
  );
  getIt.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(repository: getIt<IFavoriteNewsRepository>()),
  );
}

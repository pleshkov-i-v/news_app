import 'package:get_it/get_it.dart';
import 'package:news_app/api/dio_factory.dart';
import 'package:news_app/api/news_api_client.dart';
import 'package:news_app/data/repositories/favorite_news_repository.dart';
import 'package:news_app/data/repositories/news_article_repository.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';
import 'package:news_app/domain/repositories/i_news_article_repository.dart';
import 'package:news_app/features/favorites/cubit/favorites_cubit.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());

  getIt.registerLazySingleton<NewsApiClient>(
    () => NewsApiClient(DioFactory().createDio()),
  );
  getIt.registerFactory<INewsArticleRepository>(
    () => NewsArticleRepository(apiClient: getIt<NewsApiClient>()),
  );
  getIt.registerLazySingleton<IFavoriteNewsRepository>(
    FavoriteNewsRepository.new,
  );
  getIt.registerFactory<FavoritesCubit>(
    () => FavoritesCubit(repository: getIt<IFavoriteNewsRepository>()),
  );
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';
import 'package:news_app/features/favorites/cubit/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required IFavoriteNewsRepository repository})
    : _repository = repository,
      super(const FavoritesInitial());

  final IFavoriteNewsRepository _repository;
  StreamSubscription<Iterable<NewsArticle>>?
  _favoriteArticlesChangedSubscription;
  Future<void> init() async {
    _favoriteArticlesChangedSubscription?.cancel();
    _favoriteArticlesChangedSubscription = _repository
        .favoriteArticlesChangedStream
        .listen(_onFavoriteArticlesChanged);
    emit(const FavoritesLoading());
    try {
      final articles = await _repository.getFavoriteArticles();
      emit(FavoritesLoaded(articles.toList()));
    } catch (_) {
      emit(const FavoritesError());
    }
  }

  @override
  Future<void> close() {
    _favoriteArticlesChangedSubscription?.cancel();
    return super.close();
  }

  void _onFavoriteArticlesChanged(Iterable<NewsArticle> articles) {
    emit(FavoritesLoaded(articles.toList()));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';

import 'article_details_state.dart';

class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {
  ArticleDetailsCubit({required IFavoriteNewsRepository repository})
    : _repository = repository,
      super(const ArticleDetailsInitialState());

  final IFavoriteNewsRepository _repository;
  Future<void> init(NewsArticle article) async {
    emit(ArticleDetailsLoadingState(article: article));
    final isFavorite = await _repository.isFavorite(article.url);
    emit(ArticleDetailsLoadedState(article: article, isFavorite: isFavorite));
  }

  Future<void> toggleFavorite() async {
    final snapshot = state;
    if (snapshot is! ArticleDetailsLoadedState) return;
    final article = snapshot.article;
    final isFavorite = snapshot.isFavorite;
    emit(ArticleDetailsLoadingState(article: article));
    if (isFavorite) {
      await _repository.removeFavorite(article.url);
    } else {
      await _repository.addFavorite(article);
    }

    emit(ArticleDetailsLoadedState(article: article, isFavorite: !isFavorite));
  }
}

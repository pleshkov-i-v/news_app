import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/models/news_category.dart';
import 'package:news_app/domain/repositories/i_news_article_repository.dart';

import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required INewsArticleRepository repository})
    : _repository = repository,
      super(const NewsInitialState());

  final INewsArticleRepository _repository;

  static const int _pageSize = 10;

  Future<void> getNewsArticles() async {
    final snapshot = state;
    if (snapshot is NewsLoadingState) return;
    if (snapshot is NewsLoadedState) {
      if (snapshot.isLoadingMore || !snapshot.hasMore) return;
    }

    int page = 1;
    var updatedArticles = <NewsArticle>[];
    NewsCategory? category;
    String? searchQuery;

    if (snapshot is NewsLoadedState) {
      updatedArticles = List<NewsArticle>.from(snapshot.articles);
      page = snapshot.pagesLoaded + 1;
      category = snapshot.category;
      searchQuery = snapshot.searchQuery;
      emit(snapshot.copyWith(isLoadingMore: true));
    } else if (snapshot is NewsInitialState || snapshot is NewsErrorState) {
      category = snapshot.category;
      searchQuery = snapshot.searchQuery;
      emit(NewsLoadingState(category: category, searchQuery: searchQuery));
    } else {
      return;
    }

    try {
      final batch = await _repository.getNewsArticles(
        category: category,
        query: searchQuery,
        page: page,
      );
      final hasMore = batch.isNotEmpty;
      updatedArticles.addAll(batch);
      emit(
        NewsLoadedState(
          articles: updatedArticles,
          category: category,
          searchQuery: searchQuery,
          pagesLoaded: page,
          isLoadingMore: false,
          hasMore: hasMore,
        ),
      );
    } catch (e) {
      if (snapshot is NewsLoadedState && snapshot.articles.isNotEmpty) {
        emit(snapshot.copyWith(isLoadingMore: false));
      } else {
        emit(
          NewsErrorState(
            category: snapshot.category,
            searchQuery: snapshot.searchQuery,
          ),
        );
      }
    }
  }

  /// Reloads the first page for the current category while keeping the list on screen.
  Future<void> refreshNewsArticles() async {
    final snapshot = state;
    if (snapshot is! NewsLoadedState) return;
    if (snapshot.isLoadingMore) return;

    try {
      final batch = await _repository.getNewsArticles(
        category: snapshot.category,
        query: snapshot.searchQuery,
        page: 1,
      );
      final hasMore = batch.length >= _pageSize;
      emit(
        NewsLoadedState(
          articles: batch,
          category: snapshot.category,
          searchQuery: snapshot.searchQuery,
          pagesLoaded: 1,
          isLoadingMore: false,
          hasMore: hasMore,
        ),
      );
    } catch (_) {
      // Keep existing articles if refresh fails.
    }
  }

  void selectCategory(NewsCategory category) {
    emit(
      NewsInitialState(
        category: category == state.category ? null : category,
        searchQuery: state.searchQuery,
      ),
    );
    getNewsArticles();
  }

  Future<void> submitSearch(String raw) async {
    final trimmed = raw.trim();
    final q = trimmed.isEmpty ? null : trimmed;
    emit(NewsInitialState(category: state.category, searchQuery: q));
    await getNewsArticles();
  }
}

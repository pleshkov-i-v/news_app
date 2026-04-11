import 'package:equatable/equatable.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/models/news_category.dart';

sealed class NewsState extends Equatable {
  const NewsState({this.category, this.searchQuery});
  final NewsCategory? category;
  final String? searchQuery;
  @override
  List<Object?> get props => [category, searchQuery];
}

class NewsInitialState extends NewsState {
  const NewsInitialState({super.category, super.searchQuery});
}

class NewsLoadingState extends NewsState {
  const NewsLoadingState({super.category, super.searchQuery});
}

class NewsLoadedState extends NewsState {
  const NewsLoadedState({
    required this.articles,
    super.category,
    super.searchQuery,
    this.isLoadingMore = false,
    this.pagesLoaded = 0,
    this.hasMore = true,
  });

  final List<NewsArticle> articles;
  final bool isLoadingMore;
  final int pagesLoaded;
  final bool hasMore;

  @override
  List<Object?> get props => [
    articles,
    category,
    searchQuery,
    isLoadingMore,
    pagesLoaded,
    hasMore,
  ];

  NewsLoadedState copyWith({
    List<NewsArticle>? articles,
    NewsCategory? category,
    String? searchQuery,
    bool? isLoadingMore,
    int? pagesLoaded,
    bool? hasMore,
  }) {
    return NewsLoadedState(
      articles: articles ?? this.articles,
      category: category ?? this.category,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      pagesLoaded: pagesLoaded ?? this.pagesLoaded,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class NewsErrorState extends NewsState {
  const NewsErrorState({super.category, super.searchQuery});
}

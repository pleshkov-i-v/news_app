import 'package:equatable/equatable.dart';
import 'package:news_app/domain/models/news_article.dart';

sealed class ArticleDetailsState extends Equatable {
  const ArticleDetailsState();
  @override
  List<Object?> get props => [];
}

class ArticleDetailsInitialState extends ArticleDetailsState {
  const ArticleDetailsInitialState();
}

class ArticleDetailsLoadingState extends ArticleDetailsState {
  const ArticleDetailsLoadingState({required this.article});

  final NewsArticle article;
  @override
  List<Object?> get props => [article];
}

class ArticleDetailsLoadedState extends ArticleDetailsState {
  const ArticleDetailsLoadedState({
    required this.article,
    required this.isFavorite,
  });

  final bool isFavorite;
  final NewsArticle article;
  @override
  List<Object?> get props => [article, isFavorite];

  ArticleDetailsLoadedState copyWith({bool? isFavorite}) {
    return ArticleDetailsLoadedState(
      article: article,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

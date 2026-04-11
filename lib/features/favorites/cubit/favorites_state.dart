import 'package:equatable/equatable.dart';
import 'package:news_app/domain/models/news_article.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.articles);

  final List<NewsArticle> articles;

  @override
  List<Object?> get props => [articles];
}

class FavoritesError extends FavoritesState {
  const FavoritesError();
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';
import 'package:news_app/features/favorites/cubit/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required IFavoriteNewsRepository repository})
    : _repository = repository,
      super(const FavoritesInitial());

  final IFavoriteNewsRepository _repository;

  Future<void> load() async {
    emit(const FavoritesLoading());
    try {
      final articles = await _repository.getFavoriteArticles();
      emit(FavoritesLoaded(articles.reversed.toList()));
    } catch (_) {
      emit(const FavoritesError());
    }
  }
}

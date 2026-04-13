import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/domain/models/news_article.dart';
import 'package:news_app/domain/repositories/i_favorite_news_repository.dart';
import 'package:news_app/features/article_details/cubit/article_details_cubit.dart';
import 'package:news_app/features/article_details/presentation/article_details_content_page.dart';

class ArticleDetailsPage extends StatefulWidget {
  const ArticleDetailsPage({super.key, required this.article});

  final NewsArticle article;

  @override
  State<ArticleDetailsPage> createState() => _ArticleDetailsPageState();
}

class _ArticleDetailsPageState extends State<ArticleDetailsPage> {
  NewsArticle get article => widget.article;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleDetailsCubit>(
      create: (context) =>
          ArticleDetailsCubit(repository: getIt<IFavoriteNewsRepository>())
            ..init(article),
      child: ArticleDetailsContentPage(),
    );
  }
}

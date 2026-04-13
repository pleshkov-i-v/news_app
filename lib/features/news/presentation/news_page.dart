import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/injection.dart';
import 'package:news_app/domain/repositories/i_news_article_repository.dart';
import 'package:news_app/features/news/cubit/news_cubit.dart';
import 'package:news_app/features/news/presentation/news_page_content.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final NewsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = NewsCubit(repository: getIt<INewsArticleRepository>());
    cubit.getNewsArticles();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: const NewsPageContent(),
    );
  }
}

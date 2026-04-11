import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/cubit/news_cubit.dart';
import 'package:news_app/features/news/cubit/news_state.dart';
import 'package:news_app/features/news/presentation/widgets/news_article_card.dart';
import 'package:news_app/features/news/presentation/widgets/news_filter_bar.dart';
import 'package:news_app/features/news/presentation/widgets/news_top_bar.dart';

class NewsPageContent extends StatelessWidget {
  const NewsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const NewsTopBar(),
            NewsFilterBar(),
            const Divider(height: 1),
            Expanded(
              child: switch (state) {
                NewsInitialState() || NewsLoadingState() => const Center(
                  child: CircularProgressIndicator(),
                ),
                NewsLoadedState() => NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.axis != Axis.vertical) {
                      return false;
                    }
                    if (notification is! ScrollUpdateNotification) {
                      return false;
                    }
                    final m = notification.metrics;
                    const threshold = 240.0;
                    if (m.pixels < m.maxScrollExtent - threshold) {
                      return false;
                    }
                    if (!state.hasMore || state.isLoadingMore) {
                      return false;
                    }
                    context.read<NewsCubit>().getNewsArticles();
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: () =>
                        context.read<NewsCubit>().refreshNewsArticles(),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 140),
                      itemCount:
                          state.articles.length + (state.isLoadingMore ? 1 : 0),
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        if (index >= state.articles.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          );
                        }
                        return NewsArticleCard(article: state.articles[index]);
                      },
                    ),
                  ),
                ),
                NewsErrorState() => const Center(
                  child: Text('Error loading news articles.'),
                ),
              },
            ),
          ],
        );
      },
    );
  }
}

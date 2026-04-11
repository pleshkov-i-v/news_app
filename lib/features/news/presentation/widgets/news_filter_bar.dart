import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/models/news_category.dart';
import 'package:news_app/features/news/cubit/news_cubit.dart';
import 'package:news_app/features/news/cubit/news_state.dart';

class NewsFilterBar extends StatelessWidget {
  const NewsFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        final selectedCategory = state.category;
        return SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: NewsCategory.values.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = NewsCategory.values[index];
              final cat = category.name;
              final label = '${cat[0].toUpperCase()}${cat.substring(1)}';
              final isSelected = NewsCategory.values[index] == selectedCategory;
              return FilterChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (_) =>
                    context.read<NewsCubit>().selectCategory(category),
                showCheckmark: false,
                selectedColor: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.secondary,
                labelStyle: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                  side: BorderSide.none,
                ),
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              );
            },
          ),
        );
      },
    );
  }
}

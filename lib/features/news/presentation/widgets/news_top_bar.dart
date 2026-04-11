import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/cubit/news_cubit.dart';

class NewsTopBar extends StatefulWidget {
  const NewsTopBar({super.key});

  @override
  State<NewsTopBar> createState() => _NewsTopBarState();
}

class _NewsTopBarState extends State<NewsTopBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _expandController;
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _searchOpen = false;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _openSearch() {
    final query = context.read<NewsCubit>().state.searchQuery;
    _searchTextController.text = query ?? '';
    setState(() => _searchOpen = true);
    _expandController.forward(from: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _searchFocusNode.requestFocus();
      }
    });
  }

  void _closeSearch() {
    _searchFocusNode.unfocus();
    _expandController.reverse().then((_) {
      if (mounted) {
        setState(() => _searchOpen = false);
      }
    });
  }

  void _onSearchSubmitted(String value) {
    context.read<NewsCubit>().submitSearch(value);
    _searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _searchOpen
                ? Row(
                    key: const ValueKey('search'),
                    children: [
                      IconButton(
                        tooltip: 'Close search',
                        onPressed: _closeSearch,
                        icon: const Icon(Icons.close_rounded),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedBuilder(
                            animation: _expandController,
                            builder: (context, child) {
                              return ClipRect(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  widthFactor: Curves.easeOutCubic.transform(
                                    _expandController.value,
                                  ),
                                  child: child,
                                ),
                              );
                            },
                            child: TextField(
                              controller: _searchTextController,
                              focusNode: _searchFocusNode,
                              textInputAction: TextInputAction.search,
                              onSubmitted: _onSearchSubmitted,
                              decoration: InputDecoration(
                                hintText: 'Search headlines',
                                filled: true,
                                fillColor: theme
                                    .colorScheme
                                    .surfaceContainerHighest
                                    .withValues(alpha: 0.6),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    key: const ValueKey('title'),
                    children: [
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'News',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Search',
                        onPressed: _openSearch,
                        icon: const Icon(Icons.search_rounded),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

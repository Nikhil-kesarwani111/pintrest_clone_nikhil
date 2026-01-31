import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../pin_DetailScreen/widgets/related_pins_grid.dart';
import '../provider/search_results_provider.dart';

class SearchResultsBody extends ConsumerWidget {
  final String query;

  const SearchResultsBody({super.key, required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the API call
    final searchState = ref.watch(searchResultsProvider(query));

    return searchState.when(
      data: (pins) {
        if (pins.isEmpty) {
          return Center(
            child: Text(
              "No results found for '$query'",
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }
        // Reuse your Masonry Grid
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 10.h(context))),
            RelatedPinsGrid(pins: pins),
            SliverToBoxAdapter(child: SizedBox(height: 80.h(context))),
          ],
        );
      },
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 40, color: AppColors.primary),
            SizedBox(height: 10.h(context)),
            Text(
              "Something went wrong\n$err",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}
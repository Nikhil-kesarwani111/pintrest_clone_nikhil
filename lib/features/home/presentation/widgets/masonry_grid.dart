import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/home_provider.dart';
import 'pin_card.dart';

class MasonryGrid extends ConsumerWidget {
  const MasonryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final pins = homeState.pins;

    // Error State
    if (homeState.errorMessage != null && pins.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 40, color: Colors.red),
            const SizedBox(height: 10),
            Text("Something went wrong"),
            TextButton(
              onPressed: () => ref.read(homeControllerProvider.notifier).loadPins(refresh: true),
              child: const Text("Retry"),
            )
          ],
        ),
      );
    }

    if (homeState.isLoading && pins.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w(context)),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.h(context),
          crossAxisSpacing: 10.w(context),
          itemCount: 10,
          itemBuilder: (context, index) {
            final double height = (index % 2 == 0 ? 280 : 180).h(context);
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            );
          },
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!homeState.isLoading &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 200) {
          ref.read(homeControllerProvider.notifier).loadPins();
        }
        return false;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w(context)),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.h(context),
          crossAxisSpacing: 10.w(context),
          itemCount: pins.length + (homeState.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == pins.length) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return PinCard(pin: pins[index]);
          },
        ),
      ),
    );
  }
}
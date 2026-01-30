import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:shimmer/shimmer.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import '../../../../global/widgets/rotating_dots_indicator.dart';
import '../providers/home_provider.dart';
import 'pin_card.dart';

class MasonryGrid extends ConsumerWidget {
  const MasonryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final pins = homeState.pins;

    if (homeState.errorMessage != null && pins.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 40, color: Colors.red),
            const SizedBox(height: 10),
            const Text("Something went wrong"),
            TextButton(
              onPressed: () => ref.read(homeControllerProvider.notifier).loadPins(refresh: true),
              child: const Text("Retry"),
            )
          ],
        ),
      );
    }

    if (homeState.isLoading && pins.isEmpty) {
      return MasonryGridView.count(
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
      );
    }

    return CustomRefreshIndicator(
      offsetToArmed: 70.0,

      onRefresh: () async {
        await Future.wait([
          ref.read(homeControllerProvider.notifier).loadPins(refresh: true),
          Future.delayed(const Duration(milliseconds: 2700)), // Duration it stays visible
        ]);
      },

      builder: (BuildContext context, Widget child, IndicatorController controller) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            if (!controller.isIdle)
              Positioned(
                top: 50.h(context) * controller.value,
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF444444), // Dark Grey
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: const Center(child: RotatingFourDots(dotColor: Colors.white)),
                ),
              ),

            Transform.translate(
              offset: Offset(0, 100.0 * controller.value),
              child: child,
            ),
          ],
        );
      },

      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!homeState.isLoading &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            ref.read(homeControllerProvider.notifier).loadPins();
          }
          return false;
        },
        child: MasonryGridView.count(
          physics: const AlwaysScrollableScrollPhysics(),
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
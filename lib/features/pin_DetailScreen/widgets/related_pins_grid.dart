import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../home/domain/entities/pin_entity.dart';
import '../../home/presentation/widgets/pin_card.dart';

class RelatedPinsGrid extends StatelessWidget {
  final List<PinEntity> pins;

  const RelatedPinsGrid({super.key, required this.pins});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 4.w(context)),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h(context),
        crossAxisSpacing: 10.w(context),
        childCount: pins.length,
        itemBuilder: (context, index) {
          final pin = pins[index];

          return PinCard(
            pin: pin,
            showOverlay: true,
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/masonry_grid.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            buildCustomAppBar(context),

            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: MasonryGrid(),
              ),
            ),
          ],
        ),
      ),
    );
  } 
}
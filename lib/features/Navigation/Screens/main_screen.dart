import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/presentation/screens/home.dart';
import '../Provider/nav_provider.dart';
import '../widgets/navigation/bottom_nav_bar.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);

    final List<Widget> pages = [
      const HomeScreen(),
      const Center(child: Text("Search Screen")),
      const Center(child: Text("Create Screen")),
      const Center(child: Text("Inbox Screen")),
      const Center(child: Text("Profile Screen")),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,

      // Standard Body
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      // Standard Static Bottom Bar (Does not move)
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
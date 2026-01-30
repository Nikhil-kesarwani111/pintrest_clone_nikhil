import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../global/navigation/bottom_nav_bar.dart';
import '../../../global/provider/nav_provider.dart';
import '../../home/presentation/screens/home.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);

    // List of screens for each tab
    final List<Widget> pages = [
      const HomeScreen(),          // 0: Home
      const Center(child: Text("Search Screen")), // 1: Search (Placeholder)
      const Center(child: Text("Create Screen")), // 2: Create (Placeholder)
      const Center(child: Text("Inbox Screen")),  // 3: Inbox (Placeholder)
      const Center(child: Text("Profile Screen")),// 4: Profile (Placeholder)
    ];

    return Scaffold(
      backgroundColor: AppColors.white,

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
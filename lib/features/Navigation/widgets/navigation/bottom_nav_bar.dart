import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:pintrest_clone_nikhil/features/Navigation/widgets/navigation/widgets/build_Nav_Item.dart';
import '../../../../core/constants/app_colors.dart';
import '../../Provider/nav_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);

    return Container(
      height: 68.h(context),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w(context), vertical: 10.h(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavItem(context, ref, index: 0, label: "Home", iconSelected: CupertinoIcons.house_fill, iconUnselected: CupertinoIcons.house),
          buildNavItem(context, ref, index: 1, label: "Search", iconSelected: CupertinoIcons.search_circle_fill, iconUnselected: CupertinoIcons.search, isBoldWhenSelected: true),
          buildNavItem(context, ref, index: 2, label: "Create", iconSelected: CupertinoIcons.add, iconUnselected: CupertinoIcons.add),
          buildNavItem(context, ref, index: 3, label: "Inbox", iconSelected: CupertinoIcons.chat_bubble_text_fill, iconUnselected: CupertinoIcons.chat_bubble_text),
          AbsorbPointer(
            absorbing: true,
            child: buildNavItem(
                context,
                ref,
                index: 4,
                label: "Saved",
                iconSelected: CupertinoIcons.person_fill,
                iconUnselected: CupertinoIcons.person
            ),
          ),        ],
      ),
    );
  }

}
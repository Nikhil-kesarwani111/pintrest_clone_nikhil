import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../Navigation/widgets/navigation/bottom_nav_bar.dart';
import '../../../home/domain/entities/pin_entity.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../widgets/pin_detail_back_button.dart';
import '../../widgets/pin_media_display.dart';
import '../../widgets/pin_user_info.dart';
import '../../widgets/related_pins_grid.dart';

class PinDetailScreen extends ConsumerStatefulWidget {
  final PinEntity pin;
  const PinDetailScreen({super.key, required this.pin});

  @override
  ConsumerState<PinDetailScreen> createState() => _PinDetailScreenState();
}

class _PinDetailScreenState extends ConsumerState<PinDetailScreen> {
  //Hidden nav bar handling
  bool _isBottomBarVisible = false;

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeControllerProvider);
    final relatedPins = homeState.pins;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            NotificationListener<UserScrollNotification>(
              onNotification: (notification) {

                // When scrolling DOWN (Reading more content) -> SHOW Bar
                if (notification.direction == ScrollDirection.reverse) {
                  if (!_isBottomBarVisible) setState(() => _isBottomBarVisible = true);
                }
                // When scrolling UP (Going back to top) -> HIDE Bar
                else if (notification.direction == ScrollDirection.forward) {
                  if (_isBottomBarVisible) setState(() => _isBottomBarVisible = false);
                }
                return true;
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PinMediaDisplay(pin: widget.pin),
                        PinUserInfo(pin: widget.pin),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h(context), left: 4.w(context)),
                          child: Text(
                            "More to explore",
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp(context),
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RelatedPinsGrid(pins: relatedPins),
                  // Extra padding so content isn't covered when bar appears
                  SliverToBoxAdapter(child: SizedBox(height: 100.h(context))),
                ],
              ),
            ),

            const PinDetailBackButton(),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              // Logic remains: If visible show at 0, if hidden move down (-100)
              bottom: _isBottomBarVisible ? 0 : -100.h(context),
              left: 0,
              right: 0,
              child: const CustomBottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
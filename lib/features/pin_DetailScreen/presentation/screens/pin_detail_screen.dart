import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../home/domain/entities/pin_entity.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../widgets/pin_detail_back_button.dart';
import '../../widgets/pin_media_display.dart';
import '../../widgets/pin_user_info.dart';
import '../../widgets/related_pins_grid.dart';



class PinDetailScreen extends ConsumerWidget {
  final PinEntity pin;

  const PinDetailScreen({super.key, required this.pin});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);
    final relatedPins = homeState.pins;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        // Removed 'Expanded' as it's not needed directly inside SafeArea unless in a Column/Row
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  Media (Image/Video)
                      PinMediaDisplay(pin: pin),

                      //  User Info
                      PinUserInfo(pin: pin),

                      // "More to explore" Header
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 4.h(context),
                          left: 4.w(context),
                        ),
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

                //  Grid
                RelatedPinsGrid(pins: relatedPins),
              ],
            ),

            //  Floating Back Button
            const PinDetailBackButton(),
          ],
        ),
      ),
    );
  }
}
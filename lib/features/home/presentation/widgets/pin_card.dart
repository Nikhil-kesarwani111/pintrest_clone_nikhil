import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../global/widgets/Pin_option_bottom_sheet/Presentation/screen/pin_options_bottom_sheet.dart';
import '../../domain/entities/pin_entity.dart';
import 'video_pin.dart';

// Import the new button
import 'pin_overlay_button.dart';

class PinCard extends StatelessWidget {
  final PinEntity pin;
  final bool showOverlay; // New flag to control visibility

  const PinCard({
    super.key,
    required this.pin,
    this.showOverlay = false, // Default to false for Home Screen
  });

  Color _parseColor(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 7 || hexString.length == 9) {
        buffer.write('ff');
        buffer.write(hexString.replaceFirst('#', ''));
        return Color(int.parse(buffer.toString(), radix: 16));
      }
    } catch (e) {
      return Colors.grey[300]!;
    }
    return Colors.grey[300]!;
  }

  @override
  Widget build(BuildContext context) {
    final color = _parseColor(pin.colorHex);
    final double aspectRatio = (pin.width / pin.height);

    return GestureDetector(
      onTap: () => context.push('/pin_detail', extra: pin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              // 1. The Image/Video
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: pin.isVideo
                    ? VideoPin(
                  videoUrl: pin.videoUrl!,
                  placeholderColor: color,
                  aspectRatio: aspectRatio,
                )
                    : CachedNetworkImage(
                  imageUrl: pin.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Container(color: color),
                  ),
                  errorWidget: (context, url, error) => AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
              ),

              // 2. The Overlay Button (Only if showOverlay is true)
              if (showOverlay)
                Positioned(
                  bottom: 8.h(context),
                  right: 8.w(context),
                  child: const PinOverlayButton(),
                ),
            ],
          ),

          SizedBox(height: 5.h(context)),

          // "More" Options Button
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => PinOptionsBottomSheet(pin: pin),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(4.w(context)),
              child: Icon(Icons.more_horiz, size: 20.sp(context), color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
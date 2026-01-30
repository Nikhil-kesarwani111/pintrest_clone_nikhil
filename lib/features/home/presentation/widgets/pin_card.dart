import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/pin_entity.dart';
import 'video_pin.dart';

class PinCard extends StatelessWidget {
  final PinEntity pin;

  const PinCard({super.key, required this.pin});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: pin.isVideo
                  ? VideoPin(
                videoUrl: pin.videoUrl!,
                placeholderColor: color,
                aspectRatio: aspectRatio, // Pass ratio to Video
              )
                  : CachedNetworkImage(
                imageUrl: pin.imageUrl,
                fit: BoxFit.cover,

                placeholder: (context, url) => AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Container(
                    color: color, // The static dominant color box
                  ),
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

            if (pin.isVideo)
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "0:15", // You could make this dynamic if API provides duration
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 5.h(context)),
        const Icon(Icons.more_horiz, size: 20, color: AppColors.black),
      ],
    );
  }
}
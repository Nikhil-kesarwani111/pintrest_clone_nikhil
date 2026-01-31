import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../home/domain/entities/pin_entity.dart';
import 'detail_video_player.dart'; 

class PinMediaDisplay extends StatelessWidget {
  final PinEntity pin;

  const PinMediaDisplay({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = pin.width / pin.height;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 4.w(context),
          vertical: 4.h(context)
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w(context)),
      ),
      clipBehavior: Clip.hardEdge,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 600.h(context)),
        child: SizedBox(
          width: double.infinity,
          child: pin.isVideo
              ? DetailVideoPlayer(
            videoUrl: pin.videoUrl!,
            aspectRatio: aspectRatio,
          )
              : CachedNetworkImage(
            imageUrl: pin.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
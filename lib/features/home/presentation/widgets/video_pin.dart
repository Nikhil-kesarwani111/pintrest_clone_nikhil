import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPin extends StatefulWidget {
  final String videoUrl;
  final Color placeholderColor;
  final double aspectRatio;

  const VideoPin({
    super.key,
    required this.videoUrl,
    required this.placeholderColor,
    required this.aspectRatio,
  });

  @override
  State<VideoPin> createState() => _VideoPinState();
}

class _VideoPinState extends State<VideoPin> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  bool _isMuted = true;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeController() async {
    if (_controller != null || _hasError) return;

    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _controller!.setLooping(true);
          _controller!.setVolume(_isMuted ? 0.0 : 1.0);
          _controller!.play();
        });
      }
    } catch (e) {
      debugPrint("Video Error: $e");
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inMinutes}:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {

    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;

        // Lazy Load Logic
        if (visiblePercentage > 50) {
          if (!_isInitialized) {
            _initializeController();
          } else {
            _controller?.play();
          }
        } else {
          if (_isInitialized && _controller?.value.isPlaying == true) {
            _controller?.pause();
          }
        }
      },
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Stack(
          children: [
            Container(
              color: widget.placeholderColor,
              alignment: Alignment.center,
              child: _hasError
                  ? const Icon(Icons.broken_image, color: Colors.white54)
                  : _isInitialized
                  ? VideoPlayer(_controller!)
                  : const SizedBox(),
            ),
            if (_isInitialized) ...[
              // TOP LEFT: Timer
              Positioned(
                top: 10.h(context),
                left: 10.w(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.w(context),
                      vertical: 4.h(context)
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // White Pill
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _formatDuration(_controller!.value.duration),
                    style: TextStyle(
                      color: Colors.black, // Black Text
                      fontSize: 11.sp(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // TOP RIGHT: Mute Toggle
              Positioned(
                top: 5.h(context),
                right: 5.w(context),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isMuted = !_isMuted;
                      _controller?.setVolume(_isMuted ? 0.0 : 1.0);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2), // Subtle dark circle
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                      size: 18.sp(context),
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
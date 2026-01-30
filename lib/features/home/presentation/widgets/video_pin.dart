import 'package:flutter/material.dart';
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
          _controller!.setVolume(0.0);
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
          // Pause when scrolling away
          if (_isInitialized && _controller?.value.isPlaying == true) {
            _controller?.pause();
          }
        }
      },
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Container(
          color: widget.placeholderColor, // Solid Background Color
          alignment: Alignment.center,
          child: _hasError
              ? const Icon(Icons.broken_image, color: Colors.white54)
              : _isInitialized
              ? VideoPlayer(_controller!)
              : const SizedBox(), // Empty because Container color handles the UI
        ),
      ),
    );
  }
}
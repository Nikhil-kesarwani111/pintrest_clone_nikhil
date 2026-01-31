import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final double aspectRatio;

  const DetailVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.aspectRatio,
  });

  @override
  State<DetailVideoPlayer> createState() => _DetailVideoPlayerState();
}

class _DetailVideoPlayerState extends State<DetailVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the video plays immediately upon loading
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true); // Loop like Pinterest
        _controller.play(); // Auto-play
        _controller.setVolume(1.0); // Enable Sound
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
        color: Colors.black12,
        child: const Center(child: CircularProgressIndicator(color: Colors.black)),
      );
    }

    return AspectRatio(
      aspectRatio: widget.aspectRatio, // Use the pin's aspect ratio
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_controller),

          GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.isPlaying ? _controller.pause() : _controller.play();
              });
            },
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: !_controller.value.isPlaying
                    ? const Icon(Icons.play_circle_fill, size: 50, color: Colors.white70)
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
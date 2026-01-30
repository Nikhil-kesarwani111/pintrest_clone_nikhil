class PinEntity {
  final int id;
  final String imageUrl;
  final int width;
  final int height;
  final String colorHex;

  final bool isVideo;
  final String? videoUrl;

  const PinEntity({
    required this.id,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.colorHex,
    this.isVideo = false,
    this.videoUrl,
  });
}
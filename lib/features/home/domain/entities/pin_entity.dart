class PinEntity {
  final int id;
  final String imageUrl;
  final int width;
  final int height;
  final String colorHex;

  final String userName;

  final bool isVideo;
  final String? videoUrl;

  const PinEntity({
    required this.id,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.colorHex,
    required this.userName,
    this.isVideo = false,
    this.videoUrl,
  });
}
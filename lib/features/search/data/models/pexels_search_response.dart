import '../../../home/domain/entities/pin_entity.dart';

class PexelsSearchResponse {
  final List<PinEntity> photos;

  PexelsSearchResponse({required this.photos});

  factory PexelsSearchResponse.fromJson(Map<String, dynamic> json) {
    return PexelsSearchResponse(
      photos: (json['photos'] as List?)
          ?.map((e) => _mapPexelsToPinEntity(e))
          .toList() ?? [],
    );
  }

  static PinEntity _mapPexelsToPinEntity(Map<String, dynamic> json) {
    return PinEntity(
      id: json['id'],
      imageUrl: json['src']['large2x'] ?? json['src']['original'],
      width: json['width'] ?? 100,
      height: json['height'] ?? 100,
      colorHex: json['avg_color'] ?? '#E0E0E0',
      userName: json['photographer'] ?? 'Unknown',
      isVideo: false,
      videoUrl: null,
    );
  }
}
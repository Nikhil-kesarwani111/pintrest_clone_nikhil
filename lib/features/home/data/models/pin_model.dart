import '../../domain/entities/pin_entity.dart';

class PinModel extends PinEntity {
  const PinModel({
    required super.id,
    required super.imageUrl,
    required super.width,
    required super.height,
    required super.colorHex,
    required super.userName,
    required super.isVideo,
    super.videoUrl,
  });

  factory PinModel.fromJson(Map<String, dynamic> json) {
    String parsedUserName = "Unknown User";

    if (json.containsKey('user') && json['user'] != null) {
      parsedUserName = json['user']['name'] ?? "Unknown User";
    } else if (json.containsKey('photographer')) {
      parsedUserName = json['photographer'] ?? "Unknown User";
    }

    if (json.containsKey('video_files') &&
        json['video_files'] != null &&
        (json['video_files'] as List).isNotEmpty) {

      final List videoFiles = json['video_files'];

      final video = videoFiles.firstWhere(
            (v) => v['quality'] == 'sd',
        orElse: () => videoFiles.first,
      );

      return PinModel(
        id: json['id'],
        imageUrl: json['image'],
        width: json['width'],
        height: json['height'],
        colorHex: '#333333',
        userName: parsedUserName,
        isVideo: true,
        videoUrl: video['link'],
      );
    }

    else {
      return PinModel(
        id: json['id'],
        imageUrl: json['src'] != null
            ? (json['src']['large2x'] ?? json['src']['large'])
            : '',
        width: json['width'],
        height: json['height'],
        colorHex: json['avg_color'] ?? '#E0E0E0',
        userName: parsedUserName,
        isVideo: false,
        videoUrl: null,
      );
    }
  }
}
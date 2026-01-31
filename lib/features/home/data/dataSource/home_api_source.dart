import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/pin_model.dart';

class HomeApiSource {
  final DioClient _dioClient;

  HomeApiSource(this._dioClient);

  // Fetch Photos
  Future<List<PinModel>> fetchCuratedPhotos(int page) async {
    final response = await _dioClient.get(
      ApiConstants.curatedPhotos,
      queryParameters: {'page': page, 'per_page': 40},
    );
    return (response['photos'] as List)
        .map((json) => PinModel.fromJson(json))
        .toList();
  }

  // Fetch Videos
  Future<List<PinModel>> fetchPopularVideos(int page) async {
    final response = await _dioClient.get(
      ApiConstants.popularVideos,
      queryParameters: {'page': page, 'per_page': 50}, // Fetch fewer videos to mix in
    );
    return (response['videos'] as List)
        .map((json) => PinModel.fromJson(json))
        .toList();
  }
}
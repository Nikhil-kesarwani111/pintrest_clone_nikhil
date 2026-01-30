import 'package:flutter/foundation.dart';
import '../../domain/ repositories/home_repo.dart';
import '../../domain/entities/pin_entity.dart';
import '../dataSource/home_api_source.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeApiSource _apiSource;

  HomeRepoImpl(this._apiSource);

  @override
  Future<List<PinEntity>> getCuratedPins({int page = 1}) async {
    try {
      final results = await Future.wait([
        _apiSource.fetchCuratedPhotos(page),
        _apiSource.fetchPopularVideos(page),
      ]);

      final photos = results[0];
      final videos = results[1];

      //  Combine them
      final mixedList = [...photos, ...videos];

      mixedList.shuffle();

      return mixedList;
    } catch (e) {
      debugPrint("Repo Error: $e");
      rethrow;
    }
  }
}
///Store Pexels API Key & Base URL here


import 'secrets.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.pexels.com';


  static const String apiKey = Secrets.pexelsApiKey;

  // Photo Endpoints
  static const String curatedPhotos = '/v1/curated';
  static const String searchPhotos = '/v1/search';

  // Video Endpoints
  static const String popularVideos = '/videos/popular';
  static const String searchVideos = '/videos/search';
}
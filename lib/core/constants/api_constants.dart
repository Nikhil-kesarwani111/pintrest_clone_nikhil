///Store Pexels API Key & Base URL here


import 'package:flutter_dotenv/flutter_dotenv.dart';


class ApiConstants {
  static const String baseUrl = 'https://api.pexels.com';


  static final String apiKey = dotenv.env['PEXELS_API_KEY']!;

  // Photo Endpoints
  static const String curatedPhotos = '/v1/curated';
  static const String searchPhotos = '/v1/search';

  // Video Endpoints
  static const String popularVideos = '/videos/popular';
  static const String searchVideos = '/videos/search';
}
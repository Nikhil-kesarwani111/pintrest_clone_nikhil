///Setup Dio here

import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        // 1. Base URL
        baseUrl: ApiConstants.baseUrl,

        // 2. Timeouts
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),

        // 3. Headers
        headers: {
          'Content-Type': 'application/json',
          'Authorization': ApiConstants.apiKey,
        },
      ),
    );


    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print('network: $object'),
      ),
    );
  }

  // Generic GET method
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {

      throw _handleDioError(e);
    }
  }

  // Error Mapping Logic
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(message: 'Connection timed out');

      case DioExceptionType.connectionError:
        return NetworkException(message: 'No Internet Connection');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.statusMessage ?? 'Server Error';


        if (statusCode == 401) {
          return ServerException(message: 'Invalid API Key', statusCode: 401);
        }

        return ServerException(message: message, statusCode: statusCode);

      default:
        return ServerException(message: 'Unexpected Error occurred');
    }
  }
}
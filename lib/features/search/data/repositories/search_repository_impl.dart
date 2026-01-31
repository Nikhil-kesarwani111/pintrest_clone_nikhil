import 'package:dartz/dartz.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../home/domain/entities/pin_entity.dart';
import '../../domain/repositories/search_repository.dart';
import '../models/pexels_search_response.dart';

class SearchRepositoryImpl implements SearchRepository {
  final DioClient _dioClient;

  SearchRepositoryImpl(this._dioClient);

  @override
  Future<Either<Failure, List<PinEntity>>> searchPins(String query) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.searchPhotos,
        queryParameters: {
          'query': query,
          'per_page': 20,
          'page': 1,
        },
      );

      final pexelsResponse = PexelsSearchResponse.fromJson(response);
      return Right(pexelsResponse.photos);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/pin_entity.dart'; // Your Failure classes

abstract class SearchRepository {
  Future<Either<Failure, List<PinEntity>>> searchPins(String query);
}

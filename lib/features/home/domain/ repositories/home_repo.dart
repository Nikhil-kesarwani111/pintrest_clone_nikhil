import '../entities/pin_entity.dart';

abstract class HomeRepo {
  Future<List<PinEntity>> getCuratedPins({int page = 1});
}
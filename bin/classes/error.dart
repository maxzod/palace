/// to be captured by the main pipe we need to make the entire
/// exceptions inherits from the same class
/// also for converting exceptions to json easily
abstract class PalaceException {
  dynamic data;
  dynamic toJson();
}

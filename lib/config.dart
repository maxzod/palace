import 'package:palace/palace.dart';

abstract class PalaceConfig {
  /// will be called in case of no match with any of the registered endpoints
  static HandlerFunc notFoundHandler = (req, res) => throw NotFound();
  static bool enaleLogs = true;
}

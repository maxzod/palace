import 'package:palace/palace.dart';

abstract class PalaceConfig {
  /// will be called in case of no match with any of the registered endpoints
  static HandlerFunc notFoundHandler = (_, __) => throw NotFound();
  static bool enaleLogs = true;
}

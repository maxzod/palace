import 'package:palace/palace.dart';
import 'package:queen_env/queen_env.dart';

abstract class PalaceConfig {
  /// will be called in case of no match with any of the registered endpoints
  static HandlerFunc notFoundHandler = (req, res) => throw NotFound();

  ///
  static bool get enaleLogs => env('enableLogs') == 'true';
}

import 'package:palace/palace.dart';

abstract class PalaceController {
  final String path;
  final List<PalaceGuard> guards;
  PalaceController(
    this.path, {
    this.guards = const [],
  });
}

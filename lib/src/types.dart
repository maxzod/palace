abstract class PalaceController {
  final String path;
  final List<Function> guards;
  PalaceController(
    this.path, {
    this.guards = const [],
  });
}

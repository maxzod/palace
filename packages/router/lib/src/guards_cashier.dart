part of 'router.dart';

/// * register the path to work with `GET` methods
abstract class GuardsCashier {
  /// contains the registered guards [globally] from the `use` method
  /// `palace.use`
  final List<GuardFunc> _globalGuards = [];

  /// assign `Guard` to work globally `on any request with any method`
  void use(GuardFunc guard) => _globalGuards.add(guard);
}

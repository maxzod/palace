import 'package:path_to_regexp/path_to_regexp.dart';

// import '../http_methods.dart';
import '../type_def.dart';
import 'guard.dart';

/// every `request` must have a `endpoint` ready to handle it
/// else the `palace` will respond with `404`
/// each endpoint has its own
/// `method`
class EndPoint {
  final String path;
  final String method;
  final Handler handler;
  final List<PalaceGuard> guards;

  const EndPoint({
    required this.path,
    required this.method,
    required this.handler,
    this.guards = const [],
  });

  bool match(String method, String path) {
    final regExp = pathToRegExp(this.path);
    return this.method == method && regExp.hasMatch(path);
  }
}

import 'dart:async';

import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:palace/palace.dart';

typedef Handler = FutureOr<void> Function(Request req, Response res);
typedef Guard = FutureOr<void> Function(
    Request req, Response res, Function next);

/// every `request` must have a `endpoint` ready to handle it
/// else the `palace` will respond with `404`
/// each endpoint has its own
/// `method`
class EndPoint {
  final String path;
  final String method;
  final Handler handler;
  final List<Guard> guards;

  const EndPoint({
    required this.path,
    required this.method,
    required this.handler,
    this.guards = const [],
  });

  bool match(String method, String path) {
    final regExp = pathToRegExp(this.path);
    final methodMatch = method.toUpperCase() == 'ALL'
        ? true
        : this.method.toUpperCase() == method.toUpperCase();
    return methodMatch && regExp.hasMatch(path);
  }

  @override
  String toString() {
    return 'method: $method ,path: $path ,guardsCount${guards.length}';
  }
}

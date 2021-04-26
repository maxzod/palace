import 'dart:async';

import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:palace/palace.dart';

typedef HandlerFunc = FutureOr<Object?> Function(Request req, Response res);
typedef GuardFunc = FutureOr<Object?> Function(Request req, Response res, Function() next);

/// every `request` must have a `endpoint` ready to handle it
/// else the `palace` will respond with `res.notFoundHandler()` `404`
/// each endpoint has its own
/// `method`
class EndPoint {
  final String path;
  final String method;
  final HandlerFunc handler;
  final List<GuardFunc> guards;

  const EndPoint({
    required this.path,
    required this.method,
    required this.handler,
    this.guards = const [],
  });

  bool match(String method, String path) {
    final regExp = pathToRegExp(this.path);
    final pathMatch = regExp.hasMatch(path);
    if (this.method == '*') {
      return pathMatch;
    } else {
      final methodMatch = this.method == method.toUpperCase();
      return methodMatch && pathMatch;
    }
  }

  @override
  String toString() {
    return 'method: $method ,path: $path ,guardsCount ${guards.length}';
  }
}

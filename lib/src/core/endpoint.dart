import 'dart:async';

import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:palace/palace.dart';

typedef HandlerFunc = FutureOr<Object?> Function(Request req, Response res);
typedef GuardFunc = FutureOr<Object?> Function(Request req, Response res, Function() next);

/// every `request` must have a `endpoint` ready to handle it
/// else the `palace` will return `NotFound()`
/// each endpoint has its own `method` "GET","POST"...etc

/// TODO :: extends equtable
class EndPoint {
  /// which path to to handle ex.. /home , /login /sigup ..etc
  final String path;

  /// each endpoint has its own `method` "GET","POST" ...etc
  final String method;

  /// each function has it one and only handler wich contains the logic
  final HandlerFunc handler;

  /// each function have its own list of guards
  /// guards can be zero or more
  /// Gurds is responsopleity to execute code before and after the handler and can bloc the request to reach the handler
  final List<GuardFunc> guards;

  const EndPoint({
    required this.path,
    required this.method,
    required this.handler,
    this.guards = const [],
  });

  /// make sure if the givin method and path can match this endpoint
  bool match(String method, String path) {
    /// regx to match
    final regExp = pathToRegExp(this.path);
    final pathMatch = regExp.hasMatch(path);

    /// to match aginst all http methods in same time
    if (this.method == '*') {
      return pathMatch;
    } else {
      final methodMatch = this.method == method.toUpperCase();
      return methodMatch && pathMatch;
    }
  }

  @override
  String toString() {
    return 'method: $method , path: $path , guardsCount ${guards.length}';
  }
}

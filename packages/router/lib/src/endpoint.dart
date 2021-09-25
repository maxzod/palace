import 'package:core/core.dart';

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

  @override
  String toString() {
    return 'method: $method , path: $path , guardsCount ${guards.length}';
  }
}

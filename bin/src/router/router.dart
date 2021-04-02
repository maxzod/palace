import 'package:meta/meta.dart';

import 'endpoint.dart';

@immutable
class PalaceRouter {
  final List<EndPoint> _endpoints = [];
  final List<Handler> _globalGuards = [];
  late final Handler notFoundHandler;
  PalaceRouter({
    /// if none was provided req.notFound() will be used
    Handler? notFoundHandler,
  }) {
    this.notFoundHandler = notFoundHandler ?? (req, res) => res.notFound();
  }

  /// to add global handler for the entire app
  void use(Handler guard) => _globalGuards.add(guard);

  EndPoint? match(String method, String path) {
    try {
      return _endpoints.firstWhere((e) => e.match(method, path));
    } catch (e) {
      if (e is StateError) return null;
      rethrow;
    }
  }

  List<Handler> get guards => _globalGuards;

  void get(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) {
    // TODO :: throw error if endpoint is already reserved
    _endpoints.add(EndPoint(
      path: path,
      method: 'GET',
      handler: handler,
      guards: guards,
    ));
  }

  void post(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) {
    _endpoints.add(EndPoint(
      path: path,
      method: 'POST',
      handler: handler,
      guards: guards,
    ));
  }

  void pit(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) {
    _endpoints.add(EndPoint(
      path: path,
      method: 'POST',
      handler: handler,
      guards: guards,
    ));
  }
}

abstract class Foo {
  void printer(int x);
  int getter();
}

class Bar extends Foo {
  @override
  int getter() {
    // TODO: implement getter
    throw UnimplementedError();
  }

  @override
  void printer(int x) {
    // TODO: implement printer
  }
}

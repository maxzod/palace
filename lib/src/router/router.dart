import 'package:meta/meta.dart';

import 'endpoint.dart';
import 'package:palace/src/http/response/not_found.dart';

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

  void all(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) {
    _endpoints.add(EndPoint(
      path: path,
      method: 'ALL',
      handler: handler,
      guards: guards,
    ));
  }

  void get(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'GET',
        handler: handler,
        guards: guards,
      ));

  void post(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'POST',
        handler: handler,
        guards: guards,
      ));

  void put(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'POST',
        handler: handler,
        guards: guards,
      ));
  void patch(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'PATCH',
        handler: handler,
        guards: guards,
      ));
  void delete(
    String path,
    Handler handler, {
    List<Handler> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'DELETE',
        handler: handler,
        guards: guards,
      ));
// * throw error if endpoint is already reserved twice
  void bootstrap() {
    for (final e in _endpoints) {
      if (_endpoints.where((element) {
            if (e.method.toUpperCase() == 'ALL') {
              return e.path == element.path;
            } else {
              return e.path == element.path && e.method.toUpperCase() == element.method.toUpperCase();
            }
          }).length >
          1) {
        throw 'your endpoints have a duplicate try to fix it => $e';
      }
    }
  }
}

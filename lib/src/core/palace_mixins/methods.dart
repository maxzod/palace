part of '../palace.dart';

mixin HttpMethodsMixin {
  /// contains the registered end points form any methods like
  /// `palace.get` or `palace.post` and so on
  /// will be added here
  final _endpoints = <EndPoint>[];

  /// if the incomeng request match one the endpoints
  EndPoint? findMatch(String method, String path) {
    // TODO :: find a Better way this will perform badly when many routers exist 'BigO'
    try {
      return _endpoints.firstWhere((e) => e.match(method, path));
    } on StateError {
      return null;
    }
  }

  void register({
    required HandlerFunc handler,
    required String path,
    required String method,
    required List<GuardFunc> guards,
  }) {
    /// TODO :: validate if the provided method is supported
    _endpoints.add(
      EndPoint(
        path: path,
        method: method,
        handler: handler,
        guards: guards,
      ),
    );
  }

  /// * register the path to work with any type of methods
  void all(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) {
    _endpoints.add(
      EndPoint(
        path: path,
        method: '*',
        handler: handler,
        guards: guards,
      ),
    );
  }

  /// * register the path to work with `GET` methods
  void get(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(
        EndPoint(
          path: path,
          method: 'GET',
          handler: handler,
          guards: guards,
        ),
      );

  /// * register the path to work with `POST` methods
  void post(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(
        EndPoint(
          path: path,
          method: 'POST',
          handler: handler,
          guards: guards,
        ),
      );

  /// * register the path to work with `GET` methods
  void put(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(
        EndPoint(
          path: path,
          method: 'PUT',
          handler: handler,
          guards: guards,
        ),
      );

  /// * register the path to work with `PATCH` methods
  void patch(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(
        EndPoint(
          path: path,
          method: 'PATCH',
          handler: handler,
          guards: guards,
        ),
      );

  /// * register the path to work with `DELETE` methods
  void delete(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'DELETE',
        handler: handler,
        guards: guards,
      ));
}

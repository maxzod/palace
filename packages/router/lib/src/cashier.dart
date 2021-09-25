part of 'router.dart';

abstract class RouterCashier {
  /// contains the registered end points form any methods like
  /// `palace.get` or `palace.post` and so on
  /// will be added here
  final _endpoints = <String, EndPointGroup>{};
  Map<String, EndPointGroup> get endpoints => _endpoints;
  HandlerFunc notFoundHandler = (req, res) => throw NotFound();

  void _add(EndPoint endPoint) {
    /// create group if does not exist
    if (_endpoints[endPoint.path] == null) {
      _endpoints[endPoint.path] = EndPointGroup();
    }
    _endpoints[endPoint.path]!.add(endPoint);
  }

  /// if the incomeng request match one the endpoints
  EndPoint findMatch(String method, String path) {
    // TODO :: find a Better way this will perform badly when many routers exist 'BigO'
    for (final groupPath in _endpoints.keys) {
      /// regx to match
      final regExp = pathToRegExp(path);

      /// * does this endpoint registed with the casher ?
      final pathMatch = regExp.hasMatch(groupPath);

      if (pathMatch) {
        ///  * if true find child method
        final group = _endpoints[groupPath];
        return group!.findChild(method);
      }
    }
    return EndPoint(
      handler: notFoundHandler,
      method: method,
      path: path,
    );
  }

  void register({
    required HandlerFunc handler,
    required String path,
    required String method,
    List<GuardFunc> guards = const [],
  }) {
    _add(
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
  }) =>
      _add(
        EndPoint(
          path: path,
          method: '*',
          handler: handler,
          guards: guards,
        ),
      );

  /// * register the path to work with `GET` methods
  void get(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _add(
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
      _add(
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
      _add(
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
      _add(
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
      _add(EndPoint(
        path: path,
        method: 'DELETE',
        handler: handler,
        guards: guards,
      ));
}

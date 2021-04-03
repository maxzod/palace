import 'package:palace/palace.dart';
import 'dart:async';
import 'dart:io';

import 'package:palace/utils/logger.dart';

class Palace {
  final List<EndPoint> _endpoints = [];
  final List<Handler> _globalGuards = [];
  Handler? _notFoundHandler;
  set notFoundHandler(h) => _notFoundHandler = h;
  Handler get notFoundHandler => _notFoundHandler ?? (req, res) => res.notFound();

  HttpServer? _server;

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
  void _bootstrap() {
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

  Future<void> openGates({
    int port = 3000,
  }) async {
    // _bootstrap();

    /// open the server
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

    /// print the server url
    print('Listening on http://localhost:${_server!.port}');
    _server!.listen(_mainPipe);
  }

  Future<void> _mainPipe(HttpRequest ioReq) async {
    /// * wait for incoming requests

    try {
      /// * look for desired endpoint
      final endpoint = match(ioReq.method, ioReq.uri.path) ?? EndPoint(path: ioReq.uri.path, method: ioReq.method, handler: notFoundHandler);

      /// * create Place req form dart io req and the desired endpoint;
      final req = await Request.init(ioReq, endpoint);
      final res = Response(ioReq);

      /// build list of guards
      final handlers = <Handler>[
        /// * global handlers
        ...guards,

        ///* endpoint guards
        ...endpoint.guards,

        /// * route handler
        endpoint.handler,
      ];

      for (final handler in handlers) {
        await handler(req, res);
        if (res.isClosed) break;
      }
      throw 'Something Critical Happened !';
    } catch (e) {
      // if (allowLogs) {
      PalaceLogger.c(e);
      // }
      await Response(ioReq).internalServerError(exception: e);
    } finally {
      //  Close the req
      await ioReq.response.close();
    }
  }

  Future<void> closeGates() async => _server?.close(force: true);
}

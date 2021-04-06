import 'package:palace/palace.dart';
import 'package:palace/src/exceptions/bad_request.dart';
import 'package:palace/src/guards/body_parser.dart';
import 'dart:async';
import 'dart:io';

import 'package:palace/utils/logger.dart';

class Palace {
  /// contains the registered end points form any methods like
  /// `router.get` or `router.post` and so on
  final List<EndPoint> _endpoints = [];

  /// contains the registered guards [globally] from the `use` method
  /// `router.use`
  final List<Guard> _globalGuards = [
    /// body parser is on by default
    BodyParser(),
  ];

  /// will be called in case of no match with any of the registered endpoints
  Handler? _notFoundHandler;

  /// set not found the handler
  set notFoundHandler(Handler h) => _notFoundHandler = h;

  /// get the not found handler id none was assigned it will return the defaults 404 handler;
  Handler get notFoundHandler => _notFoundHandler ?? (Request req, Response res) => res.notFound();

  /// the server instance
  HttpServer? _server;

  /// assign `Guard` to work globally `on any request with any method`
  void use(Guard guard) => _globalGuards.add(guard);

  EndPoint? match(String method, String path) {
    // TODO :: Better way this will perform badly when many routers exist 'BigO'
    try {
      return _endpoints.firstWhere((e) => e.match(method, path));
    } on StateError {
      return null;
    }
  }

  List<Guard> get guards => _globalGuards;

  void all(
    String path,
    Handler handler, {
    List<Guard> guards = const [],
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
    List<Guard> guards = const [],
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
    List<Guard> guards = const [],
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
    List<Guard> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'PUT',
        handler: handler,
        guards: guards,
      ));
  void patch(
    String path,
    Handler handler, {
    List<Guard> guards = const [],
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
    List<Guard> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'DELETE',
        handler: handler,
        guards: guards,
      ));

  // void _bootstrap() {
  // TODO _bootstrap
  //   for (final e in _endpoints) {
  //     if (_endpoints.where((element) {
  //           if (e.method.toUpperCase() == 'ALL') {
  //             return e.path == element.path;
  //           } else {
  //             return e.path == element.path && e.method.toUpperCase() == element.method.toUpperCase();
  //           }
  //         }).length >
  //         1) {
  //       throw 'your endpoints have a duplicate try to fix it => $e';
  //     }
  //   }
  // }

  Future<void> openGates({
    int port = 3000,
    bool enableLogs = true,
  }) async {
    // TODO :: Set the `enableLogs` to true by default in debug only
    if (enableLogs) {
      final tempGuards = [..._globalGuards];
      _globalGuards.clear();
      _globalGuards.addAll([LogsGuard(), ...tempGuards]);
    }
    await _server?.close(force: true);

    /// open the server
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

    /// print the server url
    print('Listening on http://localhost:$port');

    /// add listener to incoming requests stream
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
      final guardsCount = guards.length + endpoint.guards.length;
      final queue = <Function>[];

      for (var i = 0; i <= guardsCount; i++) {
        queue.add(() {
          if (i == guardsCount) {
            /// last guard NEXT will call the endpoint handler
            return () => endpoint.handler(req, res);
          } else {
            /// next will call the next guard
            return () => guards[i](req, res, queue[i + 1]());
          }
        });
      }

      await queue.first()();
    } on BadRequest catch (e) {
      await Response(ioReq).badRequest(data: e.data);
    } catch (e, st) {
      Logger.c(e, st: st);
      await Response(ioReq).internalServerError(exception: e);
    } finally {
      ///  Close the req
      await ioReq.response.close();
    }
  }

  Future<void> closeGates() async => await _server?.close(force: true);
}

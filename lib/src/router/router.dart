import 'package:palace/palace.dart';
import 'package:palace/src/excpetions/bad_request.dart';
import 'dart:async';
import 'dart:io';

import 'package:palace/utils/logger.dart';

class Palace {
  final List<EndPoint> _endpoints = [];
  final List<Guard> _globalGuards = [];
  Handler? _notFoundHandler;
  set notFoundHandler(Handler h) => _notFoundHandler = h;
  Handler get notFoundHandler => _notFoundHandler ?? (Request req, Response res) => res.notFound();

  HttpServer? _server;

  /// to add global handler for the entire app
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
        method: 'POST',
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

  ///  TODO : throw error if endpoint is already reserved twice
  // void _bootstrap() {
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
  }) async {
    // _bootstrap();
    if (_server != null) {
      print(_server);
      await _server!.close(force: true);
    }

    /// open the server
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);

    /// print the server url
    print('Listening on http://localhost:$port');
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
      PalaceLogger.c(e, st: st);
      await Response(ioReq).internalServerError(exception: e);
    } finally {
      //  Close the req
      await ioReq.response.close();
    }
  }

  Future<void> closeGates() async => await _server?.close(force: true);

  // Future<void> closeGates() async {
  //   // idk but still does not work
  //   // Future<void> closeGates() async => await _server?.close(force: true);
  //   if (_server != null) {
  //     await _server!.close(force: true);
  //   }
  // }
}

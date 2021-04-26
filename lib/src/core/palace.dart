import 'package:palace/config.dart';
import 'package:palace/palace.dart';
import 'package:palace/src/guards/body_parser.dart';
import 'package:palace/src/http/responses/internal_server_error.dart';
import 'package:palace/src/imp/palace_response.dart';
import 'package:palace/src/http/file.dart';
import 'dart:async';
import 'dart:io';

import 'package:palace/utils/logger.dart';

class Palace {
  /// contains the registered end points form any methods like
  /// `router.get` or `router.post` and so on
  final List<EndPoint> _endpoints = [];

  /// contains the registered guards [globally] from the `use` method
  /// `router.use`
  final List<GuardFunc> _globalGuards = [
    /// body parser is on by default
    BodyParser(),
  ];

  /// the server instance
  HttpServer? _server;

  /// assign `Guard` to work globally `on any request with any method`
  void use(GuardFunc guard) => _globalGuards.add(guard);

  EndPoint? match(String method, String path) {
    // TODO(2) :: find a Better way this will perform badly when many routers exist 'BigO'
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
    _endpoints.add(EndPoint(
      path: path,
      method: method,
      handler: handler,
      guards: guards,
    ));
  }

  void all(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) {
    _endpoints.add(EndPoint(
      path: path,
      method: '*',
      handler: handler,
      guards: guards,
    ));
  }

  void get(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'GET',
        handler: handler,
        guards: guards,
      ));

  void post(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'POST',
        handler: handler,
        guards: guards,
      ));

  void put(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'PUT',
        handler: handler,
        guards: guards,
      ));
  void patch(
    String path,
    HandlerFunc handler, {
    List<GuardFunc> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'PATCH',
        handler: handler,
        guards: guards,
      ));
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
    String? ip,
  }) async {
    _bootstrap();
    // await PalaceDB.init();
    ip ??= InternetAddress.anyIPv4.address;
    if (PalaceConfig.enaleLogs) {
      _globalGuards.insert(0, LogsGuard());
    }
    await _server?.close(force: true);

    /// open the server
    _server = await HttpServer.bind(ip, port);

    /// print the server url
    print('Listening on http://localhost:$port');

    /// add listener to incoming requests stream
    _server!.listen(_mainPipe);
  }

  Future<void> _mainPipe(HttpRequest ioReq) async {
    /// * wait for incoming requests
    try {
      /// * look for desired endpoint
      final endpoint = match(ioReq.method, ioReq.uri.path) ??
          EndPoint(
            path: ioReq.uri.path,
            method: ioReq.method,
            handler: PalaceConfig.notFoundHandler,
          );

      /// * create Place req form dart io req and the desired endpoint;
      final req = await Request.init(ioReq, endpoint);
      final res = Response(ioReq);

      /// build list of guards

      final _reqGuards = <GuardFunc>[..._globalGuards, ...endpoint.guards];
      final queue = [];
      // Future<void> handelCall(Function func) async{
      //   await

      // }
      for (var i = 0; i <= _reqGuards.length; i++) {
        if (i == _reqGuards.length) {
          queue.add(() => endpoint.handler(req, res));
        } else {
          queue.add(() => _reqGuards[i](req, res, queue[i + 1]));
        }
      }

      await _handleResponse(req, res, await queue.first());
    } on PalaceResponse catch (e) {
      Response(ioReq).json(e.toMap(), statusCode: e.statusCode);
    } catch (e, st) {
      await Logger.e(e, st: st);
      Response(ioReq).json(InternalServerError(e).toMap());
    } finally {
      ///  Close the req
      await ioReq.response.close();
    }
  }

  Future<void> _handleResponse(Request req, Response res, dynamic data) async {
    if (data is String) {
      res.send(data);
    } else if (data is Map) {
      res.json(data);
    } else if (data is PalaceResponse) {
      res.json(data.toMap(), statusCode: data.statusCode);
    } else if (data is File) {
      await file(req.request, res.response, data);
    }
  }

  Future<void> closeGates() async => await _server?.close(force: true);
}

import 'package:palace/palace.dart';
import 'package:palace/src/core/chief_handler.dart';
import 'package:palace/src/exceptions/imp_exception.dart';
import 'package:palace/src/guards/body_parser.dart';
import 'package:palace/src/core/collector.dart';
import 'package:palace/src/types.dart';
import 'dart:async';
import 'dart:io';

import 'package:palace/utils/logger.dart';

class Palace {
  /// contains the registered end points form any methods like
  /// `router.get` or `router.post` and so on
  final List<EndPoint> _endpoints = [];

  /// contains the registered guards [globally] from the `use` method
  /// `router.use`
  final List<PalaceGuard> _globalGuards = [
    /// body parser is on by default
    BodyParser(),
  ];

  /// will be called in case of no match with any of the registered endpoints
  Function? _notFoundHandler;

  /// set not found the handler
  set notFoundHandler(Function h) => _notFoundHandler = h;

  /// get the not found handler id none was assigned it will return the defaults 404 handler;
  Function get notFoundHandler => _notFoundHandler ?? (Request req, Response res) => res.notFound();

  /// the server instance
  HttpServer? _server;

  /// assign `Guard` to work globally `on any request with any method`
  void use(PalaceGuard guard) => _globalGuards.add(guard);

  EndPoint? match(String method, String path) {
    // TODO :: find a Better way this will perform badly when many routers exist 'BigO'
    try {
      return _endpoints.firstWhere((e) => e.match(method, path));
    } on StateError {
      return null;
    }
  }

  void controllers(List<PalaceController> controllers) {
    final collector = Collector(controllers, this);
    collector.collect();
  }

  void register({
    required Function handler,
    required String path,
    required String method,
    required List<PalaceGuard> guards,
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
    Function handler, {
    List<PalaceGuard> guards = const [],
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
    Function handler, {
    List<PalaceGuard> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'GET',
        handler: handler,
        guards: guards,
      ));

  void post(
    String path,
    Function handler, {
    List<PalaceGuard> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'POST',
        handler: handler,
        guards: guards,
      ));

  void put(
    String path,
    Function handler, {
    List<PalaceGuard> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'PUT',
        handler: handler,
        guards: guards,
      ));
  void patch(
    String path,
    Function handler, {
    List<PalaceGuard> guards = const [],
  }) =>
      _endpoints.add(EndPoint(
        path: path,
        method: 'PATCH',
        handler: handler,
        guards: guards,
      ));
  void delete(
    String path,
    Function handler, {
    List<PalaceGuard> guards = const [],
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
    bool enableLogs = true,
  }) async {
    _bootstrap();
    // await PalaceDB.init();
    ip ??= InternetAddress.anyIPv4.address;
    if (enableLogs) {
      final tempGuards = [..._globalGuards];
      _globalGuards.clear();
      _globalGuards.addAll([
        // LogsGuard(),
        ...tempGuards,
      ]);
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
      final endpoint = match(ioReq.method, ioReq.uri.path) ?? EndPoint(path: ioReq.uri.path, method: ioReq.method, handler: notFoundHandler);

      /// * create Place req form dart io req and the desired endpoint;
      final req = await Request.init(ioReq, endpoint);
      final res = Response(ioReq);

      /// build list of guards

      final _reqGuards = [..._globalGuards, ...endpoint.guards];
      final queue = <Function>[];

      for (var i = 0; i <= _reqGuards.length; i++) {
        if (i == _reqGuards.length) {
          queue.add(() => chiefHandler(req, res, endpoint.handler, null));
        } else {
          queue.add(() => chiefHandler(req, res, _reqGuards[i].handle, queue[i + 1]));
        }
      }
    
      // for (var i = 0; i <= _reqGuards.length; i++) {
      //   if (i == _reqGuards.length) {
      //     queue.add(() => endpoint.handler(req, res));
      //   } else {
      //     queue.add(() => _reqGuards[i].handle(req, res, queue[i + 1]));
      //   }
      // }
      await queue.first();
    } on PalaceException catch (e) {
      await Response(ioReq).json(e.toMap(), statusCode: e.statusCode);
    } catch (e, st) {
      Logger.c(e, st: st);
      await Response(ioReq).internalServerError(exception: e);
    } finally {
      ///  Close the req
      //await ioReq.response.close();
    }
  }

  Future<void> closeGates() async => await _server?.close(force: true);
}

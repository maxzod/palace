import 'package:palace/config.dart';
import 'package:palace/palace.dart';
import 'package:palace/src/guards/body_parser.dart';
import 'package:palace/src/http/responses/internal_server_error.dart';
import 'package:palace/src/imp/palace_response.dart';
import 'package:palace/src/http/file.dart';
import 'dart:async';
import 'dart:io';

import 'package:palace/utils/logger.dart';
import 'package:queen_env/queen_env.dart';

part 'palace_mixins/methods.dart';
part 'palace_mixins/guards.dart';

class Palace with HttpMethodsMixin, PalaceGuardsMixin {
  /// the server instance
  HttpServer? _server;

  /// * register the path to work with `GET` methods
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
        // TODO :: better error message
        throw 'your endpoints have a duplicate try to fix it => $e';
      }
    }
  }

  /// * open the server and start listening for the incoming requests
  Future<void> openGates({
    int port = 3000,
    String? ip,
  }) async {
    /// load .env file
    await loadEnv();

    /// add global palace guards
    _globalGuards.addAll(
      [
        /// if logs enabled the logsGuard will be the first one
        if (PalaceConfig.enaleLogs) LogsGuard(),

        /// body parser is on by default
        BodyParser(),
      ],
    );

    /// checks for endpoints dublicate
    _bootstrap();

    /// await PalaceDB.init();
    ip ??= InternetAddress.anyIPv4.address;

    /// incase of old server is on it will forcly close it
    await _server?.close(force: true);

    /// create the new server
    _server = await HttpServer.bind(ip, port);

    if (PalaceConfig.enaleLogs) {
      /// print the server url
      print('Listening on http://localhost:$port');
    }

    /// add listener to incoming requests stream
    _server!.listen(_mainPipe);
  }

  Future<void> _mainPipe(HttpRequest ioReq) async {
    /// * wait for incoming requests
    try {
      /// * look for desired endpoint
      /// if none it will use `notFoundHandler` from `PalaceConfig`
      final endpoint = findMatch(ioReq.method, ioReq.uri.path) ??
          EndPoint(
            path: ioReq.uri.path,
            method: ioReq.method,
            handler: PalaceConfig.notFoundHandler,
          );

      /// * create Place req form dart io req and the desired endpoint;
      final req = await Request.init(ioReq, endpoint);

      /// * create palace res from the incoming request
      final res = Response(ioReq);

      /// * build list of guards from the public guards then the request gurads
      final _reqGuards = <GuardFunc>[
        ..._globalGuards,
        ...endpoint.guards,
      ];

      /// idk what i have done here its was 3 month ago so i will leave it like this for now
      final queue = [];

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
      /// if logs enabled log the err
      if (PalaceConfig.enaleLogs) await Logger.e(e, st: st);
      Response(ioReq).json(InternalServerError(e).toMap());
    } finally {
      ///* Close the req
      await ioReq.response.close();
    }
  }

  Future<void> _handleResponse(Request req, Response res, dynamic data) async {
    // TODO :: sever Views in future
    if (data is String) {
      res.send(data);
    } else if (data is Map) {
      res.json(data);
    } else if (data is PalaceResponse) {
      res.json(data.toMap(), statusCode: data.statusCode);
    } else if (data is File) {
      await file(req.request, res.response, data);
    } else {
      res.send(data);
    }
  }

  Future<dynamic>? closeGates() => _server?.close(force: true);
}

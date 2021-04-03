import 'dart:async';
import 'dart:io' as io;

import 'package:palace/palace.dart';

import 'http/request.dart';
import 'http/response/response.dart';
import 'router/endpoint.dart';
import 'router/router.dart';

Future<void> openGates(
  PalaceRouter palaceRouter, {
  int port = 3000,
}) async {
  /// open the server
  final server = await io.HttpServer.bind(io.InternetAddress.loopbackIPv4, port);

  /// print the server url
  print('Listening on http://localhost:${server.port}');

  /// * wait for incoming requests
  await for (final ioReq in server) {
    try {
      /// * look for desired endpoint
      final endpoint = palaceRouter.match(ioReq.method, ioReq.uri.path) ??
          EndPoint(path: ioReq.uri.path, method: ioReq.method, handler: palaceRouter.notFoundHandler);

      /// * create Place req form dart io req and the desired endpoint;
      final req = await Request.init(ioReq, endpoint);
      final res = Response(ioReq);

      /// build list of guards
      final handlers = <Handler>[
        /// * global handlers
        ...palaceRouter.guards,

        ///* endpoint guards
        ...endpoint.guards,

        /// * route handler
        endpoint.handler,
      ];

      for (final handler in handlers) {
        await handler(req, res);
        if (res.isClosed) break;
      }
    } catch (e) {
      if (allowLogs) {
        // TODO :: log this exception
      }
      await Response(ioReq).internalServerError(exception: e);
    }
  }
}

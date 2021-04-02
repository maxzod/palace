import 'dart:async';
import 'dart:io' as io;

import 'http/request.dart';
import 'http/response.dart';
import 'router/endpoint.dart';
import 'router/router.dart';

Future<void> openGates(
  PalaceRouter palaceRouter, {
  int port = 3000,
}) async {
  /// open the server
  final server = await io.HttpServer.bind(io.InternetAddress.loopbackIPv4, port);

  /// print url
  print('Listening on http://localhost:${server.port}');

  /// * wait for incoming requests
  await for (final ioReq in server) {
    try {
      // int? x;
      // print(x!);

      /// * create Place req form dart io req;
      final req = Request(ioReq);
      final res = Response(ioReq);

      /// * look for desired endpoint
      final endpoint = palaceRouter.match(ioReq.method, ioReq.uri.path) ??
          EndPoint(path: ioReq.uri.path, method: ioReq.method, handler: palaceRouter.notFoundHandler);

      /// build list of guards
      final handlers = <Handler>[
        /// * global handlers
        ...palaceRouter.guards,
        ...endpoint.guards,

        /// * route handler
        endpoint.handler,
      ];

      for (final handler in handlers) {
        await handler(req, res);
        if (res.isClosed) break;
      }
    } catch (e) {
      /// error
      await Response(ioReq).internalServerError(data: e);
    }
  }
}

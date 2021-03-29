import 'dart:io' as io;

import 'endpoint.dart';
import 'req.dart';
import 'res.dart';
import 'router.dart';

Future<void> openGates(
  PalaceRouter router, {
  int port = 4040,
}) async {
  /// open the server
  final server = await io.HttpServer.bind(io.InternetAddress.loopbackIPv4, 4040);

  /// print url
  print('Listening on http://localhost:${server.port}');

  /// * wait for incoming requests
  await for (final ioReq in server) {
    try {
      /// * create Place req form dart io req;
      final req = Request(ioReq);
      final res = Response(ioReq);

      /// * look for desired endpoint
      final endpoint = router.match(
        ioReq.method,
        ioReq.uri.path,
      );
      if (endpoint == null) {
        res.notFound();
        return;
      }

      /// build list of guards
      final handlers = <Handler>[
        // global handlers
        ...router.guards.map((e) => e.handleBefore),

        /// route handlers
        ...endpoint.guards.map((e) => e.handleBefore),

        /// * after finish with guards
        /// * call the endpoint handler
        endpoint.handler,
      ];

      /// * loop throw the handlers

      for (final handler in handlers) {
        await handler(req, res);

        if (res.isClosed) break;
      }
    } catch (e) {
      // error
      await Response(ioReq).internalServerError(data: e);
    } finally {
      /// close the `request`
      await ioReq.response.close();
    }
  }
}

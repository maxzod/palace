import 'dart:io' as io;

import '../router.dart';
import 'error.dart';
import 'req.dart';

Future<void> _endReq(Request req, dynamic res) async {
  return req.response.close();
}

Future<void> openGates(
  PalaceRouter router, {
  int port = 4040,
}) async {
  /// open the server
  final server =
      await io.HttpServer.bind(io.InternetAddress.loopbackIPv4, 4040);

  /// print url
  print('Listening on localhost:${server.port}');

  /// * wait for incoming requests
  await for (final ioReq in server) {
    try {
      /// * create Place req form dart io req;
      final req = Request(ioReq);

      /// * look for desired endpoint
      final endpoint = router.match(
        ioReq.method,
        ioReq.uri.path,
      );

      /// build list of guards
      final guards = [...router.guards, ...endpoint.guards];

      /// * loop throw global palace guards
      /// * loop throw endpoint guards;

      for (final guard in guards) {
        final res = await guard.handle(req);

        /// if the guard returned any data
        /// this will end the req and respond with the incoming data from the guard
        /// else will run the next guard and so on
        if (res != null) return await _endReq(req, res);
      }

      /// * after finish with guards (no response data from them);
      /// * call the endpoint handler
      final res = await endpoint.handler(req);

      /// if the handler hasn't return any data
      /// close the request
      if (res == null) {
        // no return but every thing is fine
        // just close the req
        return await _endReq(req, res);
      } else {
        // three is data from the req
        ioReq.response.write(res);
      }
    } on PalaceException catch (e) {
      ioReq.response.write(e);
    } catch (e) {
      ioReq.response.write(e);
    } finally {
      /// close the req
      await ioReq.response.close();
    }
  }
}

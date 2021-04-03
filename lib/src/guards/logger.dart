import 'package:palace/palace.dart';

/// log the incoming requests in debug mode only within the console it self
Future<void> loggerGuard(Request req, Response res) async {
  final enableLog = !config<bool>('production');

  if (enableLog) {
    await res.json({'data': req.queryParams});
  }
}
// ip : ${req.connectionInfo!.remoteAddress}

import 'package:palace/palace.dart';

// remove parsing the body functionally from the request in place it here
// it would be more clear
class LogsGuard {
  void call(Request req, Response res, Function next) async {
    PalaceLogger.c('''
    req to => ${req.ioRequest.uri.path},
    method => ${req.method}
    ''');
    await next();
  }
}

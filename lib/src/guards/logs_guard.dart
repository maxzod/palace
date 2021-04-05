import 'package:palace/palace.dart';

class LogsGuard {
  void call(Request req, Response res, Function next) async {
    COLORS.c('''
    req to => ${req.ioRequest.uri.path},
    method => ${req.method}
    ''');
    return await next();
  }
}

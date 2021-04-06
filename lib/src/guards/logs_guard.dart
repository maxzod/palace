import 'package:palace/palace.dart';

class LogsGuard {
  void call(Request req, Response res, Function next) async {
    Logger.c('''
    req to => ${req.request.uri.path},
    method => ${req.method}
    ''');
    return await next();
  }
}

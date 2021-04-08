import 'package:palace/palace.dart';

class LogsGuard {
  void call(Request req, Response res, Function next) async {
    Logger.c('''
    req to => ${req.path},
    method => ${req.method}
    ''');
    return await next();
  }
}

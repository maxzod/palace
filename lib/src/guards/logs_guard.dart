import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';

class LogsGuard {
  const LogsGuard();
  void call(
    Request req,
    Response res,
    @Next() Function next,
  ) async {
    Logger.c('''
    req to => ${req.path},
    method => ${req.method}
    ''');
    return await next();
  }
}

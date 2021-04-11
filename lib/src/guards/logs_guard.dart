import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';

class LogsGuard extends PalaceGuard {
  const LogsGuard();
  @override
  void handle(Request req, Response res, @Next() Function next) async {
    Logger.c('''
    req to => ${req.path},
    method => ${req.method}
    ''');
    return await next();
  }
}

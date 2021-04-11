import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';

class CorsGuard {
  Future<void> call(Request req, Response res, @Next() Function next) async {}
}

import 'package:http_server/http_server.dart';
import 'package:palace/palace.dart';

class BodyParser {
  void call(Request req, Response res, next) async {
    final _reqBody = await HttpBodyHandler.processRequest(req.ioRequest);
    req.body = _reqBody.body;
    req.bodyType = _reqBody.type;
    await next();
  }
}

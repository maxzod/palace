import 'package:http_server/http_server.dart';
import 'package:palace/palace.dart';

/// will parse the incoming request so if `json` `req.body` type will be `Map` and so on
class BodyParser {
  void call(Request req, Response res, next) async {
    /// convert the incoming request body
    final _reqBody = await HttpBodyHandler.processRequest(req.ioRequest);

    /// it will be Map<String,dynamic>
    req.body = _reqBody.body;

    /// might be json or form
    req.bodyType = _reqBody.type;
    await next();
  }
}

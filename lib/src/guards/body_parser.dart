import 'package:palace_body_parser/palace_body_parser.dart' as parser;
import 'package:palace/palace.dart';

/// will parse the incoming request so if `json` `req.body` type will be `Map` and so on
class BodyParser {
  void call(Request req, Response res, Function next) async {
    final parsedBody = await parser.parseBodyFromStream(
      req.request,
      req.request.headers.contentType != null
          ? parser.MediaType.parse(req.request.headers.contentType.toString())
          : null,
      req.request.uri,
      storeOriginalBuffer: false,
    );
    req.body = parsedBody.body;

    /// call the next guard or handler
    await next();
  }
}

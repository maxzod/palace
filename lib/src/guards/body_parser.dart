import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace_body_parser/palace_body_parser.dart' as parser;
import 'package:palace/palace.dart';

/// will parse the incoming request so if `json` `req.body` type will be `Map` and so on

class BodyParser extends PalaceGuard {
  @override
  void handle(Request req, Response res, @Next() next) async {
    print('bb');
    // try {
    //   final parsedBody = await parser.parseBodyFromStream(
    //     req.request,
    //     req.request.headers.contentType != null ? parser.MediaType.parse(req.request.headers.contentType.toString()) : null,
    //     req.request.uri,
    //     storeOriginalBuffer: false,
    //   );
    //   req.body = parsedBody.body;
    // } catch (e) {
    //   print(e);
    // }

    /// call the next guard or handler
    await next();
  }
}

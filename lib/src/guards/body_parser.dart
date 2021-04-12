import 'dart:async';

import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace_body_parser/palace_body_parser.dart' as parser;
import 'package:palace/palace.dart';
import 'dart:convert';

/// will parse the incoming request so if `json` `req.body` type will be `Map` and so on

class BodyParser extends PalaceGuard {
  @override
  FutureOr<void> handle(Request req, Response res, @Next() next) async {
    var body = await req.request.transform(utf8.decoder.cast()).join();

    if (body.isEmpty) {
      req.body = {};
      // print('body is : ');
      // print(req.body);
      return await next();
    } else {
      try {
        req.body = jsonDecode(body);
        // print('body is : ');
        // print(req.body);
        return await next();
      } catch (e) {
        var queryParams = Uri.splitQueryString(body);
        req.body = queryParams;
        // print('body is : ');
        // print(req.body);
        return await next();
      }
    }
  }
}

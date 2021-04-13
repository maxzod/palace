import 'dart:async';

import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace/palace.dart';
import 'dart:convert';

/// will parse the incoming request so if `json` `req.body` type will be `Map` and so on

final supportedContentTypes = [
  'application/x-www-form-urlencoded',
  'multipart/form-data',
  'application/json',
  // TODO(2) :: parse files
];

class BodyParser {
  FutureOr<void> call(Request req, Response res, @Next() next) async {
    final _contentType = req.request.headers.contentType.toString();

    if (supportedContentTypes.contains(_contentType)) {
      var body = await req.request.transform(utf8.decoder.cast()).join();
      if (body.isEmpty) {
        req.body = {};
      } else if (_contentType == 'application/json') {
        req.body = jsonDecode(body);
      } else if (_contentType == 'multipart/form-data' || _contentType == 'application/x-www-form-urlencoded') {
        var queryParams = Uri.splitQueryString(body);
        req.body = queryParams;
      }
    } else {
      req.body = {};
    }
    // return res.send(next);
    return await next();
  }
}

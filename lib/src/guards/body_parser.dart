import 'dart:async';

import 'package:palace/palace.dart';
import 'dart:convert';

/// will parse the incoming request so if `json` `req.body` type will be `Map` and so on
// TODO :: parse files

final supportedContentTypes = [
  'application/x-www-form-urlencoded',
  'multipart/form-data',
  'application/json',
];

class BodyParser {
  FutureOr<Object?> call(Request req, Response res, Function next) async {
    var body = await req.request.transform(utf8.decoder.cast()).join();
    // return req.contentType;
    if (req.contentType == 'application/x-www-form-urlencoded') {
      req.body = Uri.splitQueryString(body);
    } else if (req.contentType.contains('multipart/form-data')) {
      // return body;
      // req.body = parseFormData(body);
      // TODO :: parse form-data
      req.body = {};
    } else if (req.contentType == 'application/json') {
      req.body = jsonDecode(body);
    } else {
      req.body = {};
    }
    return req.body;

    return await next();
  }
}

Map<String, dynamic> parseFormData(String body) {
  final reqBody = <String, dynamic>{};

  return {
    'foo': body,
  };
}

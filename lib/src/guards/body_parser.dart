import 'dart:async';

import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace/palace.dart';
import 'dart:convert';

/// will parse the incoming request so if `json` `req.body` type will be `Map` and so on

final supportedContentTypes = [
  'application/x-www-form-urlencoded',
  'multipart/form-data',
  'application/json',
  // TODO :: parse files
  // 'null',
];

class BodyParser extends PalaceGuard {
  @override
  FutureOr<void> handle(Request req, Response res, @Next() next) async {
    final _contentType = req.request.headers.contentType.toString();

    /// clear message to inform the developers
    if (!supportedContentTypes.contains(_contentType)) {
      return res.badRequest(data: {
        'msg': 'palace only support ${supportedContentTypes.length} content types and yours is not one of them',
        'request content type': _contentType,
        'support_types': supportedContentTypes
      });
    }

    var body = await req.request.transform(utf8.decoder.cast()).join();

    if (body.isEmpty) {
      req.body = {};
    } else if (_contentType == 'application/json') {
      req.body = jsonDecode(body);
    } else if (_contentType == 'multipart/form-data' || _contentType == 'application/x-www-form-urlencoded') {
      var queryParams = Uri.splitQueryString(body);
      req.body = queryParams;
    }

    return await next();
  }
}

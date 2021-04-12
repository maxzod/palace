import 'dart:async';
import 'dart:io';

import 'package:palace/palace.dart';

extension ResponseWithJson on Response {
  FutureOr<void> json(
    Object data, {
    int? statusCode,
  }) async {
    /// set the Response contentType to Json
    response.headers.contentType = ContentType.json;

    /// set the default status code
    // response.statusCode = statusCode ?? defStatusCode;

    /// append the data to the response
    await send(toJson(data));
  }
}

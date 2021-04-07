import 'dart:io' as io;
import 'package:palace/palace.dart';

/// status code 200

extension ResponseWithOk on Response {
  /// will response with status code 201
  /// will end the request life-cycle
  /// the guards still work but the can not respond or
  /// modify the response any more
  Future<void> ok({
    Object? data,
  }) async {
    /// set the Response contentType to Json
    response.headers.contentType = io.ContentType.json;

    /// set the status code
    response.statusCode = io.HttpStatus.ok;

    /// append the data to the response
    await send(toJson(
      {
        'status_code': io.HttpStatus.ok,
        'message': 'Ok',
        if (data != null) 'data': data,
      },
    ));
  }
}

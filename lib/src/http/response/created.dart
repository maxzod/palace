import 'dart:io' as io;
import 'package:palace/palace.dart';

/// status code 201

extension ResponseWithCreated on Response {
  /// will response with status code 201
  /// will end the request life-cycle
  /// the guards still work but the can not respond or
  /// modify the response any more
  Future<void> created({
    Object? data,
  }) async {
    /// set the Response contentType to Json
    response.headers.contentType = io.ContentType.json;

    /// set the status code
    response.statusCode = io.HttpStatus.created;

    /// append the data to the response
    await send(toJson(
      {
        'status_code': io.HttpStatus.created,
        'message': 'Created',
        if (data != null) 'data': data,
      },
    ));
  }
}

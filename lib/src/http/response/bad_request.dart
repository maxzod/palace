import 'dart:io' as io;
import 'package:palace/palace.dart';

extension ResponseWithBadRequest on Response {
  Future<void> badRequest({
    Object? data,
  }) async {
    /// set the Response contentType to Json
    response.headers.contentType = io.ContentType.json;

    response.statusCode = io.HttpStatus.badRequest;

    /// append the data to the response
    await write(toJson(
      {
        'status_code': io.HttpStatus.badRequest,
        'message': 'Bad Request',
        if (data != null) 'data': data,
      },
    ));
  }
}
